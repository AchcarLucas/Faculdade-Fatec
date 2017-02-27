#include <iostream>
#include "include/hashtable.h"

// FILA DINÂMICA LIGADA

using namespace std;

int main(){
    Hash hash;

    /*hash.insertInt(10);
    hash.insertInt(11);
    hash.insertInt(12);
    hash.insertInt(13);
    hash.insertInt(14);
    hash.insertInt(15);
    hash.insertInt(16);
    hash.insertInt(17);
    hash.insertInt(18);
    hash.insertInt(19);
    hash.insertInt(20);

    for(int i = 0; i < W; i++){
        hash.displayListInt(i);
    }*/

    hash.insertString("Thais");
    hash.insertString("Bia");
    hash.insertString("Lucy");
    hash.insertString("Yara");
    hash.insertString("Sueli");
    hash.insertString("Edu");
    hash.insertString("Neusa");
    hash.insertString("Rose");
    hash.insertString("Decio");
    hash.removeString("Yara");
    hash.removeString("Decio");
    hash.removeString("Thais");
    hash.removeString("Lucy");

    for(int i = 0; i < W; i++){
        hash.displayListString(i);
    }

    return 0;
}
