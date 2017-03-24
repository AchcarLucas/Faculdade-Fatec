#include <iostream>

using namespace std;

template <class T>
void bubbleSortGrowing(T *order, uint32_t length){
    bool isOrder;
    do{
        isOrder = false;
        for(uint32_t i = 0; i < length - 1; i++){
            if(order[i] > order[i + 1]){
                swap(order[i], order[i + 1]);
                isOrder = true;
            }
        }
    }while(isOrder);
}

template <class T>
void bubbleSortDecreasing(T *order, uint32_t length){
    bool isOrder;
    do{
        isOrder = false;
        for(uint32_t i = 0; i < length - 1; i++){
            if(order[i] < order[i + 1]){
                swap(order[i], order[i + 1]);
                isOrder = true;
            }
        }
    }while(isOrder);
}

int main(){
    float order[] = {1, 10.5, 10.4, 50, 20, 48, 30, 24, 42, 41, 42, 2, 3, 4};
    uint32_t order_length = static_cast<uint32_t>(sizeof(order)) / sizeof(float);
    bubbleSortGrowing<float>(order, order_length);
    for(uint32_t i = 0; i < order_length; i++){
        cout << order[i] << " ";
    }
    return 0;
}
