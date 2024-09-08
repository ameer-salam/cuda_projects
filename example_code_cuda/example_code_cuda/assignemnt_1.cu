#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <random>

//cpu addition function
void cpu_addition(int* a, int* b, int* c, int* results, int size)
{
	for (int i = 0; i < size; i++)
	{
		results[i] = a[i] + b[i] + c[i];	
	}
	printf("CPU calculations done!\n");
}

//gpu addition function
__global__ void gpu_addition(int *a, int *b, int *c, int *d, int size)
{
	int gid = threadIdx.x + (blockIdx.x * blockDim.x);
	if (gid < size)
	{
		d[gid] = a[gid] + b[gid] + c[gid];
	}
}

void compare(int *a, int *b, int size)
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

int main()
{
	int array_size = 4194304;
	int array_byte_size = 4194304 * sizeof(int);
	int *a1, *a2, *a3 ,*c_result, *g_results;

	//allocating memeory for the array1 and array2
	a1 = (int*)malloc(array_byte_size);
	a2 = (int*)malloc(array_byte_size);
	a3 = (int*)malloc(array_byte_size);
	c_result = (int*)malloc(array_byte_size);
	g_results = (int*)malloc(array_byte_size);

	//randomly allocating elements to the  arays
	for (int i = 0; i < array_size; i++)
	{
		a1[i] = rand() % 1000 + 1;
		a2[i] = rand() % 1000 + 1;
		a3[i] = rand() % 1000 + 1;
	}

	//cpu addition function
	clock_t cpu_clock_start, cpu_clock_stop;
	cpu_clock_start = clock();
	cpu_addition(a1, a2, a3, c_result, array_size);
	cpu_clock_stop = clock();

	//preparing for the kernel function
	//declaring pointer variables to point to the device memory
	int *d_a1, *d_a2, *d_a3, *d_results;

	//allocating memory to store the variables
	cudaMalloc((int**)&d_a1, array_byte_size);
	cudaMalloc((int**)&d_a2, array_byte_size);
	cudaMalloc((int**)&d_a3, array_byte_size);
	cudaMalloc((int**)&d_results, array_byte_size);

	//transfering data from host to the device
	cudaMemcpy(d_a1, a1, array_byte_size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_a2, a2, array_byte_size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_a3, a3, array_byte_size, cudaMemcpyHostToDevice);

	//declaring the grid and block
	int block_size = 128;
	dim3 block(block_size);
	dim3 grid(array_size / block_size);

	//calling the kernel function
	clock_t gpu_clock_start, gpu_clock_stop;
	gpu_clock_start = clock();
 	gpu_addition << <grid, block>> > (d_a1, d_a2, d_a3, d_results, array_size);
	cudaDeviceSynchronize();
	gpu_clock_stop = clock();

	//copying back the result from GPU to CPU
	cudaMemcpy(g_results, d_results, array_byte_size, cudaMemcpyDeviceToHost);


	//comparission function
	compare(c_result, g_results, array_size);

	free(a1); free(a2); free(a3); free(c_result); free(g_results);
	cudaDeviceReset();

	return 0;
}