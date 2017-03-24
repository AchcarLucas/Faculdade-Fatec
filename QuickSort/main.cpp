// Lucas Campos
#include <iostream>

using namespace std;

template <class T>
void quickSort(T *order, uint32_t start, uint32_t end);

template <class T>
uint32_t particione(T *order, uint32_t start, uint32_t end);

template <class T>
void sort(T *order, uint32_t length){
    uint32_t start = 0;
    uint32_t end = length;
    quickSort(order, start, end);
}

template <class T>
void quickSort(T *order, uint32_t start, uint32_t end){
    if(start < end){
        uint32_t pivot = particione(order, start, end);
        quickSort(order, start, end - 1);
        quickSort(order, start + 1, end);
    }
}

template <class T>
uint32_t particione(T *order, uint32_t start, uint32_t end){
    T pivot = order[end];
    uint32_t index = start; // current pivot wall

    for(uint32_t j = start; j < end; j++){
        if(order[j] < pivot){
            swap(order[j], order[index]);
            index++;
        }
    }

    swap(order[index], order[end]);
	return index;
}

int main(){
    //float order[] = {1, 10.5, 10.4, 50, 20, 48, 30, 24, 42, 41, 42, 2, 3, 4};
    float order[] = {10, 9, 5, 8, 7, 2, 3, 5, 1};
    uint32_t order_length = static_cast<uint32_t>(sizeof(order)) / sizeof(float);
    sort<float>(order, order_length);
    for(uint32_t i = 0; i < order_length; i++){
        cout << order[i] << " ";
    }
    return 0;
}
