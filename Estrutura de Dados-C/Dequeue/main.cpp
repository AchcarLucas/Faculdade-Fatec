#include <iostream>
#include "include/fila.h"
#include "include/dequeue.h"

// FILA DINÂMICA LIGADA

using namespace std;

int main(){
    /*Fila <int> fila;
    fila.insert(10);
    fila.insert(20);
    fila.insert(30);
    fila.clear();

    int size = fila.getSize();

    for(int i = 0; i < size; i++){
        cout << fila.remove() << endl;
    }*/


    Dequeue<int> fila_dupla;
    fila_dupla.insert_end(10);
    cout << "Primeiro " << fila_dupla.primeiro() << endl;
    cout << "Ultimo " << fila_dupla.ultimo() << endl;
    fila_dupla.insert_end(20);
    cout << "Primeiro " << fila_dupla.primeiro() << endl;
    cout << "Ultimo " << fila_dupla.ultimo() << endl;
    fila_dupla.insert_end(30);

    cout << fila_dupla.remove_end() << endl;
    fila_dupla.insert_end(40);
    cout << fila_dupla.remove_head() << endl;

    fila_dupla.insert_head(100);
    fila_dupla.insert_head(200);
    fila_dupla.insert_end(100);
    fila_dupla.insert_end(200);

    int size = fila_dupla.getFila()->getSize();

    for(int i = 0; i < size; i++){
        cout << fila_dupla.remove_end() << endl;
    }

    return 0;
}
