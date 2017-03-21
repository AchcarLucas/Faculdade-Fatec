#ifndef HASHTABLE_H_INCLUDED
#define HASHTABLE_H_INCLUDED

#include <iostream>
#include <functional>
#include <string>

const unsigned int W = 7;

struct Node{
    int info;
    Node *prox;
};

struct NodeS{
    std::string info;
    NodeS *prox;
};

struct Hash{
    Node *h[W];
    NodeS *ns[W];
    Hash(){
        for(int i = 0; i < W; i++){
            h[i] = NULL;
            ns[i] = NULL;
        }
    };
    int fht(int x) {return (x % W);};
    int adh(std::string s) {
        int sum = 0;
        for(int i = 0; i < s.length(); i++){
            sum += uint16_t(s[i]);
        }
        return (sum % W);
    };
    bool emptyListInt(int list){return h[list]==NULL;};
    bool emptyListString(int list){return ns[list]==NULL;};
    void insertInt(int x){
        std::cout << "Inserted " << x << " FHT (" << fht(x) << ")" << std::endl;
        Node *aux = new Node;
        aux->info = x;
        if(h[fht(x)] == NULL){
            aux->prox = h[fht(x)];
            h[fht(x)] = aux;
        }else{
            Node *tmp = h[fht(x)];
            while(tmp->prox != NULL && tmp->prox->info < x){
                tmp = tmp->prox;
            }
            aux->prox = tmp->prox;
            tmp->prox = aux;
        }
    };
    void insertString(std::string s){
        std::cout << "Inserted " << s << " ADH (" << adh(s) << ")" << std::endl;
        NodeS *aux = new NodeS;
        aux->info = s;
        if(ns[adh(s)] == NULL){
            aux->prox = ns[adh(s)];
            ns[adh(s)] = aux;
        }else{
            NodeS *tmp = ns[adh(s)];
            while(tmp->prox != NULL && tmp->prox->info[0] < s[0]){
                tmp = tmp->prox;
            }
            aux->prox = tmp->prox;
            tmp->prox = aux;
        }
    };

    std::string removeString(std::string s){
        uint16_t list = adh(s);
        std::cout << "Removed " << s << " ADH (" << adh(s) << ")" << std::endl;
        NodeS *tmp = ns[list];

        if(tmp != NULL && tmp->info == s){
            std::string retns = tmp->info;
            NodeS *aux = tmp;
            ns[list] = tmp->prox;
            delete aux;
            return retns;
        }

        while(tmp->prox != NULL){
            if(tmp->prox->info == s){
                std::string retns = tmp->info;
                NodeS *aux = tmp->prox;
                tmp->prox = aux->prox;
                delete aux;
                return retns;
            }
            tmp = tmp->prox;
        }

        return NULL;
    }

    void displayListInt(int list){
        list = list % W;
        Node *tmp = h[list];
        std::cout << "List (" << list << "): ";
        while(tmp != NULL){
            std::cout << tmp->info << " ";
            tmp = tmp->prox;
        }
        std::cout << std::endl;
    };

    void displayListString(int list){
        list = list % W;
        NodeS *tmp = ns[list];
        std::cout << "List (" << list << "): ";
        while(tmp != NULL){
            std::cout << tmp->info << " ";
            tmp = tmp->prox;
        }
        std::cout << std::endl;
    };
};

#endif // HASHTABLE_H_INCLUDED
