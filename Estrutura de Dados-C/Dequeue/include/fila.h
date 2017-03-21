#ifndef FILA_H_INCLUDED
#define FILA_H_INCLUDED

template <typename T>
struct Node{
    T x;
    Node *prox;
};

template <typename T>
struct Fila{
    unsigned int size;
    Node <T> *inic, *fim;
    Fila();
    ~Fila();
    void clear();
    bool Empty();
    bool insert(T);
    T remove();
    T getHead();
    T getEnd();
    unsigned getSize();
    Node<T> * getNodeHead();
    Node<T> * getNodeEnd();

    void setNodeHead(Node<T> *aux);
    void setNodeEnd(Node<T> *aux);
};

template <typename T>
Fila<T>::Fila(){
    inic = NULL;
    fim = inic;
    size = 0;
}

template <typename T>
Fila<T>::~Fila(){
    clear();
}

template <typename T>
void Fila<T>::clear(){
    Node<T> *aux = inic;
    while(aux != NULL){
        inic = inic->prox;
        delete aux;
        aux = inic;
    }
    fim = NULL;
    size = 0;
}

template <typename T>
bool Fila<T>::insert(T x){
    Node<T> *aux = new Node<T>;
    if(aux != NULL){
        aux->x = x;
        aux->prox = NULL;
        if(inic == NULL){
            inic = aux;
        }else{
            fim->prox = aux;
        }
        fim = aux;
        size++;
        return true;
    }
    return false;
}

template <typename T>
T Fila<T>::remove(){
    Node <T> *aux = inic;
    inic = inic->prox;
    if(inic == NULL){
        fim = NULL;
    }
    T x = aux->x;
    delete aux;
    size--;
    return x;
}

template <typename T>
bool Fila<T>::Empty(){
    return inic == NULL;
}

template <typename T>
T Fila<T>::getHead(){
    return inic->x;
}

template <typename T>
T Fila<T>::getEnd(){
    return fim->x;
}

template <typename T>
unsigned Fila<T>::getSize(){
    return size;
}

template <typename T>
Node<T> * Fila<T>::getNodeHead(){
    return inic;
}

template <typename T>
Node<T> * Fila<T>::getNodeEnd(){
    return fim;
}

template <typename T>
void Fila<T>::setNodeHead(Node<T> *aux){
    inic = aux;
}

template <typename T>
void Fila<T>::setNodeEnd(Node<T> *aux){
    fim = aux;
}

#endif // FILA_H_INCLUDED
