#ifndef DEQUEUE_H_INCLUDED
#define DEQUEUE_H_INCLUDED

#include <iostream>

#include "fila.h"

template <typename T>
struct Dequeue{
    Node <T> *inic, *fim;
    Fila <T> *fila;
    Dequeue();
    ~Dequeue();

    void insert_head(T);
    void insert_end(T);

    T remove_head();
    T remove_end();

    T primeiro();
    T ultimo();

    Fila<T> *getFila();
};

template <typename T>
Dequeue<T>::Dequeue(){
    fila = new Fila<T>;
}

template <typename T>
Dequeue<T>::~Dequeue(){
    delete fila;
}

template <typename T>
void Dequeue<T>::insert_head(T x){
    inic = fila->getNodeHead();
    Node<T> *aux = new Node<T>;
    if(aux != NULL){
        aux->x = x;
        aux->prox = inic;
        inic = aux;
        fila->setNodeHead(inic);
        fila->size++;
    }
}

template <typename T>
void Dequeue<T>::insert_end(T x){
    fila->insert(x);
}

template <typename T>
T Dequeue<T>::remove_head(){
    return fila->remove();
}

template <typename T>
T Dequeue<T>::remove_end(){
    fim = fila->getNodeEnd();
    inic = fila->getNodeHead();

    Node<T> *aux = inic;
    T x;
    if(aux != NULL){
        if(aux->prox == NULL){
            x = aux->x;
            delete aux;
            fim = inic = NULL;
            fila->setNodeEnd(fim);
            fila->setNodeHead(inic);
            fila->size--;
            return x;
        }else{
            Node<T> *forward = inic->prox;
            Node<T> *previous = aux;
            while(forward->prox != NULL){
                previous = forward;
                forward = forward->prox;
            }
            x = previous->prox->x;
            delete previous->prox;
            previous->prox = NULL;
            fila->setNodeEnd(previous);
            fila->size--;
            return x;
        }
    }
}

template <typename T>
T Dequeue<T>::primeiro(){
    return fila->getHead();
}

template <typename T>
T Dequeue<T>::ultimo(){
    return fila->getEnd();
}

template <typename T>
Fila<T> *Dequeue<T>::getFila(){
    return fila;
}

#endif // DEQUEUE_H_INCLUDED
