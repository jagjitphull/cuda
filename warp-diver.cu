#include <iostream>

__global__ void divergenceExample(int *array) {
    int tid = threadIdx.x;
    if (tid % 2 == 0) {
        // Even threads perform this operation
        array[tid] = tid * 2;
    } else {
        // Odd threads perform this operation
        array[tid] = tid * 3;
    }
}

int main() {
    const int arraySize = 16;
    int *d_array;
    cudaMalloc(&d_array, arraySize * sizeof(int));

    // Launch the kernel with 1 block and 16 threads
    divergenceExample<<<1, arraySize>>>(d_array);

    // Copy the result back to host
    int h_array[arraySize];
    cudaMemcpy(h_array, d_array, arraySize * sizeof(int), cudaMemcpyDeviceToHost);

    // Print the result
    std::cout << "Result: ";
    for (int i = 0; i < arraySize; ++i) {
        std::cout << h_array[i] << " ";
    }
    std::cout << std::endl;

    cudaFree(d_array);

    return 0;
}
