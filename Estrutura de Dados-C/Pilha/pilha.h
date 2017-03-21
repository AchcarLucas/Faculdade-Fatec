#ifndef PILHA_H_INCLUDED
#define PILHA_H_INCLUDED

template <typename Tipo>
struct Node{
    Tipo info;
    Node<Tipo> *prox;
};

template <typename Tipo>
struct Pilha{
    Node<Tipo> *topo;
    Pilha();
    ~Pilha();
    bool empilha(Tipo x);
    Tipo desempilha();
    Tipo elementodotopo();
    bool pilhavazia();
    Node<Tipo> *getTopo();
};

template <typename Tipo>
Pilha<Tipo>::Pilha(){
    topo = NULL;
}

template <typename Tipo>
bool Pilha<Tipo>::pilhavazia(){
    return topo == NULL;
}

template <typename Tipo>
bool Pilha<Tipo>::empilha(Tipo x){
    bool v = false;
    Node<Tipo> *aux = new Node<Tipo>;
    if(aux !=NULL){
        aux->info=x;
        aux->prox=topo;
        topo = aux;
        v = true;
    }
    return v;
}

template <typename Tipo>
Tipo Pilha<Tipo>::desempilha(){
    Tipo temp = topo->info;
    Node<Tipo> *aux = topo;
    topo = topo->prox;
    delete aux;
    return temp;
}

template <typename Tipo>
Tipo Pilha<Tipo>::elementodotopo(){
    return topo->info;
}

template <typename Tipo>
Pilha<Tipo>::~Pilha(){
    Node<Tipo> *aux = topo;
    while(aux != NULL){
        topo = topo->prox;
        delete aux;
        aux = topo;
    }
}

template <typename Tipo>
Node<Tipo> *Pilha<Tipo>::getTopo(){
    return topo;
}
#endif // PILHA_H_INCLUDED
