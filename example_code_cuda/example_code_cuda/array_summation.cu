#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <random>

__global__ void array_summation(int *a, int *b, int *c, int size)
{
	int gid = threadIdx.x + (blockDim.x * blockIdx.x);
	if (gid < size)
		c[gid] = a[gid] + b[gid];
}

int main()
{
	int array_size = 10; 
	int array_byte_size = array_size * sizeof(int);
	int *a1, *a2, *result;

	//allocating memory space for the array1, array2 and reult
	a1 = (int*)malloc(array_byte_size);
	a2 = (int*)malloc(array_byte_size);
	result = (int*)malloc(array_byte_size);

	//assigning values to the array space
	for (int i = 0; i < array_size; i++)
	{
		a1[i] = rand() % 100;
		a2[i] = rand() % 100;
	}
	printf("The randomly choosen elements are : \n");
	for (int i = 0; i < array_size; i++)
		printf("a1[%d] : %d\ta2[%d] : %d\n", i, a1[i], i, a2[i]);

	//declaring device variables and allocing memory for the same
	int *d_a1, *d_a2, *d_result;
	cudaMalloc((int**)&d_a1, array_byte_size);
	cudaMalloc((int**)&d_a2, array_byte_size);
	cudaMalloc((int**)&d_result, array_byte_size);

	//copying the values form the host to device variables
	cudaMemcpy(d_a1, a1, array_byte_size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_a2, a2, array_byte_size, cudaMemcpyHostToDevice);

	array_summation << 1, array_size >> (&d_a1, &d_a2, &d_result, array_size);

	cudaDeviceSynchronize();

	cudaMemcpy(d_result, result, array_byte_size, cudaMemcpyHostToDevice);
	
	for (int i = 0; i < array_size; i++)
		printf("a1[%d] + a1[%d] = %d\n", i, i, result[i]);
	
	cudaDeviceReset();
	return 0;
}