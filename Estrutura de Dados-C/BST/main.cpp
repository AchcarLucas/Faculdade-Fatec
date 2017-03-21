#include <iostream>
#include "bst.h"

using namespace std;

int mt(int a, int b){
    if(b == 1)
        return a;
    else
        return mt(a, b - 1) + a;
}

int main(){
    cout << mt(2, 5) << endl;
    Bst <char>bst;
    bst.insert(bst.pRoot, 4);
    bst.insert(bst.pRoot, 14);
    bst.insert(bst.pRoot, 30);
    bst.insert(bst.pRoot, 48);
    bst.insert(bst.pRoot, 7);
    bst.preOrder(bst.pRoot);
    cout << endl;
    bst.inOrder(bst.pRoot);
    cout << endl;
    bst.posOrder(bst.pRoot);
    cout << endl << bst.maxValue(bst.pRoot)->info;
    bst.displayBST(bst.pRoot);

    return 0;
}
