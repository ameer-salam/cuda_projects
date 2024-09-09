#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <random>
#include <chrono>

// CPU addition function
void cpu_addition(int* a, int* b, int* c, int* results, int size)
{
    for (int i = 0; i < size; i++)
    {
        results[i] = a[i] + b[i] + c[i];
    }
    printf("CPU calculations done!\n");
}

// GPU addition function
__global__ void gpu_addition(int* a, int* b, int* c, int* d, int size)
{
    int gid = threadIdx.x + (blockIdx.x * blockDim.x);
    if (gid < size)
    {
        d[gid] = a[gid] + b[gid] + c[gid];
    }
}

void compare(int* a, int* b, int size)
{
    for (int i = 0; i < size; i++)
    {
        if (a[i] != b[i])
        {
            printf("They do not match!");
            return;
        }
    }
    printf("\nThe arrays Match!\n\n");
    int randno = rand() % size + 1;
    printf("Example : cpu_result[%d] = %d\tgpu_result[%d] = %d\n", randno, a[randno], randno, b[randno]);
    randno = rand() % size + 1;
    printf("Example : cpu_result[%d] = %d\tgpu_result[%d] = %d\n", randno, a[randno], randno, b[randno]);
}

//int main()
//{
//    int array_size = 4194304;
//    int array_byte_size = 4194304 * sizeof(int);
//    int* a1, * a2, * a3, * c_result, * g_results;
//    cudaError error;
//
//    // Allocating memory for the arrays
//    a1 = (int*)malloc(array_byte_size);
//    a2 = (int*)malloc(array_byte_size);
//    a3 = (int*)malloc(array_byte_size);
//    c_result = (int*)malloc(array_byte_size);
//    g_results = (int*)malloc(array_byte_size);
//
//    // Randomly allocating elements to the arrays
//    for (int i = 0; i < array_size; i++)
//    {
//        a1[i] = rand() % array_size + 1;
//        a2[i] = rand() % array_size + 1;
//        a3[i] = rand() % array_size + 1;
//    }
//
//    // CPU addition function
//    auto cpu_start = std::chrono::high_resolution_clock::now();
//    cpu_addition(a1, a2, a3, c_result, array_size);
//    auto cpu_stop = std::chrono::high_resolution_clock::now();
//    std::chrono::duration<double> cpu_duration = cpu_stop - cpu_start;
//
//    // Preparing for the kernel function
//    // Declaring pointer variables to point to the device memory
//    int* d_a1, * d_a2, * d_a3, * d_results;
//
//    // Allocating memory to store the variables on the device
//    error = cudaMalloc((void**)&d_a1, array_byte_size);
//    error = cudaMalloc((void**)&d_a2, array_byte_size);
//    error = cudaMalloc((void**)&d_a3, array_byte_size);
//    error = cudaMalloc((void**)&d_results, array_byte_size);
//
//    // Transferring data from host to the device
//    cudaMemcpy(d_a1, a1, array_byte_size, cudaMemcpyHostToDevice);
//    cudaMemcpy(d_a2, a2, array_byte_size, cudaMemcpyHostToDevice);
//    cudaMemcpy(d_a3, a3, array_byte_size, cudaMemcpyHostToDevice);
//
//    // Declaring the grid and block
//    int block_size = 512;
//    dim3 block(block_size);
//    dim3 grid(array_size / block_size);
//
//    // Using cudaEvent to measure GPU time
//    cudaEvent_t start, stop;
//    cudaEventCreate(&start);
//    cudaEventCreate(&stop);
//
//    // Starting GPU timing
//    cudaEventRecord(start);
//    gpu_addition << <grid, block >> > (d_a1, d_a2, d_a3, d_results, array_size);
//    cudaEventRecord(stop);
//
//    // Waiting for the event to complete
//    cudaEventSynchronize(stop);
//
//    // Calculating elapsed time
//    float milliseconds = 0;
//    cudaEventElapsedTime(&milliseconds, start, stop);
//
//    // Copying back the result from GPU to CPU
//    cudaMemcpy(g_results, d_results, array_byte_size, cudaMemcpyDeviceToHost);
//
//    // Comparison function
//    compare(c_result, g_results, array_size);
//
//    // Printing the time
//    printf("CPU time: %4.16f seconds\n", cpu_duration.count());
//    printf("GPU time: %4.16f seconds\n", milliseconds / 1000.0);
//
//    // Freeing memory
//    free(a1); free(a2); free(a3); free(c_result); free(g_results);
//    cudaFree(d_a1); cudaFree(d_a2); cudaFree(d_a3); cudaFree(d_results);
//    cudaEventDestroy(start);
//    cudaEventDestroy(stop);
//    cudaDeviceReset();
//
//    return 0;
//}
