#ifndef BST_H_INCLUDED
#define BST_H_INCLUDED

#include <sstream>
#include <iostream>
#include <iomanip>

/*
    1.0 - insere (OK)
    2.0 - remove (OK)
    3.0 - busca (OK)
    4.0 - máximo valor (OK)
    5.0 - mínimo valor (OK)
    6.0 - exibir a árvore
    6.1 - pre ordem (OK)
    6.2 - em ordem (OK)
    6.3 - pos ordem (OK)
*/

template <typename Type>
struct Node{
    Type info;
    Node<Type> *pLeft;
    Node<Type> *pRight;
};

template <typename Type>
struct Bst{
    Node <Type> *pRoot;

    // Construct
    Bst();

    void insert(Node<Type> *&t, Type x);
    Node<Type> * search(Node<Type> *&t, Type x);
    Node<Type> * minValue(Node<Type> *&);
    Node<Type> * maxValue(Node<Type> *&);
    void inOrder(Node<Type> *t);
    void preOrder(Node<Type> *t);
    void posOrder(Node<Type> *t);
    void displayBST(Node<Type> *t, int l = 0);
    Node<Type> * remove(Node<Type> *&t, Type value);
};

template <typename Type>
Bst<Type>::Bst(){
    pRoot = NULL;
}


template <typename Type>
void Bst<Type>::insert(Node<Type> *&t, Type x){
    if(t == NULL){
        t = new Node<Type>;
        t->info = x;
        t->pLeft = t->pRight = NULL;
    }else{
        if(x < t->info){
            insert(t->pLeft, x);
        }else{
            insert(t->pRight, x);
        }
    }
}

template <typename Type>
Node<Type> * Bst<Type>::search(Node<Type> *&t, Type x){
    if(t == NULL || t->info == x){
        return t;
    }else if(t->info > x){
        return search(t->pLeft, x);
    }else{
        return search(t->pRight, x);
    }
}

template <typename Type>
Node<Type> * Bst<Type>::minValue(Node<Type> *&t){
    if(t == NULL || t->pLeft == NULL){
        return t;
    }else{
        minValue(t->pLeft);
    }
}

template <typename Type>
Node<Type> * Bst<Type>::maxValue(Node<Type> *&t){
    if(t == NULL || t->pRight == NULL){
        return t;
    }else{
        maxValue(t->pRight);
    }
}

template <typename Type>
void Bst<Type>::inOrder(Node<Type> *t){
    if(t != NULL){
        inOrder(t->pLeft);
        std::cout << t->info << " ";
        inOrder(t->pRight);
    }
}

template <typename Type>
void Bst<Type>::preOrder(Node<Type> *t){
    if(t != NULL){
        std::cout << t->info << " ";
        preOrder(t->pLeft);
        preOrder(t->pRight);
    }
}

template <typename Type>
void Bst<Type>::posOrder(Node<Type> *t){
    if(t != NULL){
        posOrder(t->pLeft);
        posOrder(t->pRight);
        std::cout << t->info << " ";
    }
}

template <typename Type>
void Bst<Type>::displayBST(Node<Type> *t, int l){
	if(t != NULL) {
        if(t->pRight) {
            displayBST(t->pRight, l+4);
        }
        if (l) {
            std::cout << std::setw(l) << ' ';
        }
        if (t->pRight) std::cout<<" /\n" << std::setw(l) << ' ';
        std::cout<< t->info << "\n ";
        if(t->pLeft) {
            std::cout << std::setw(l) << ' ' <<" \\\n";
            displayBST(t->pLeft, l+4);
        }
    }
}

template <typename Type>
Node<Type> * Bst<Type>::remove(Node<Type> *&t, Type value){
    if(t == NULL){
        return t;
    }

    if(value < t->info){
        t->pLeft = remove(t->pLeft, value);
    }else{
        t->pRight = remove(t->pRight, value);
    }

    if(t->info == value){
        if(t->pLeft == NULL){
            Node <Type> *tmp = t->pRight;
            delete t;
            return tmp;
        }else if(t->pRight == NULL){
            Node <Type> *tmp = t->pLeft;
            delete t;
            return tmp;
        }

        Node <Type> *tmp = minValue(t->pRight);
        t->info = tmp->info;
        t->pRight = remove(t->pRight, tmp->info);
    }
    return t;
}

#endif // BST_H_INCLUDED
