// Lucas Campos
#include <iostream>

using namespace std;

template <class T>
void partition(T *order, uint32_t index, uint32_t length);

template <class T>
void selectionSort(T *order, uint32_t index, uint32_t length){
    if(index < length){
        partition(order, index, length);
        selectionSort(order, index + 1, length);
    }
}

template <class T>
void partition(T *order, uint32_t index, uint32_t length){
    uint32_t indexMin = index;
    for(uint32_t i = index + 1; i < length; i++){
        if(order[i] < order[indexMin]){
            indexMin = i;
        }
    }

    swap(order[index], order[indexMin]);
}

int main(){
    int order[] = {1, 10, 10, 50, 20, 48, 30, 24, 42, 41, 42, 2, 3, 4};
    uint32_t order_length = static_cast<uint32_t>(sizeof(order)) / sizeof(int);
    selectionSort<int>(order, 0, order_length);
    for(uint32_t i = 0; i < order_length; i++){
        cout << order[i] << " ";
    }
    return 0;
    return 0;
}
