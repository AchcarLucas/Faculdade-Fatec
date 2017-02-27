#include <iostream>
#include "pilha.h"
using namespace std;
int main()
{
    cout << "Pilha Ligada" << endl;
    Pilha<int> p;
    if(!p.empilha(5)){
        cout<<"nao consegui empilhar..."<<endl;
    }
    p.empilha(3);
    p.empilha(2);
    p.empilha(1);
    p.empilha(9);
    Node<int> *aux=p.getTopo();
    while(aux != NULL){
        cout<<aux->info<<endl;
        aux=aux->prox;
    }
    return 0;
}
