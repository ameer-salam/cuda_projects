#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <random>

__global__ void array_summation_2(int *a, int *b, int *c, int size)
{
	int gid = threadIdx.x + (blockDim.x * blockIdx.x);
	if (gid < size)
	{
		c[gid] = a[gid] + b[gid];
	}
}

void array_summation_2_cpu(int *a, int *b, int *c, int size)
{
	printf("CPU Summation function called!\n");
	for (int i = 0; i < size; i++)
	{
		c[i] = a[i] + b[i];
	}
	//below statement is just for validation
	//printf("CPU Summation of a1[998] : %d\t + a2[998] : %d\t is = %d\n", a[998], b[998], c[998]);
}

void array_summation_2_validation(int *a, int *b, int size)
{
	printf("validation function called!\n");
	for (int i = 0; i < size; i++)
	{
		if (a[i] != b[i])
		{
			printf("They do not match!\b");
			return;
		}
	}
	printf("\n\nArrays match! and have been validated!\n");
}

//int main()
//{
//	int array_size = 1000;
//	int array_byte_size = array_size * sizeof(int);
//	int *a1, *a2, *result, *c_results;
//	
//	//declaring variable of type cudaError to store the error value
//	cudaError error;
//	
//	//allocating memory space for the above variables a1, a2, result
//	a1 = (int*)malloc(array_byte_size);
//	a2 = (int*)malloc(array_byte_size);
//	result = (int*)malloc(array_byte_size);
//
//	//generating random numbers and storing them in the above array
//	for (int i = 0; i < array_size; i++)
//	{
//		a1[i] = rand() % 100 + 1;
//		a2[i] = rand() % 100 + 1;
//	}
//
//	//printing the randomly generated array elements
//	for (int i = 0; i < array_size; i++)
//	{
//		printf("a1[%d] : %d\ta2[%d] : %d\n", i, a1[i], i, a2[i]);
//	}
//
//	//declaring variables to store the memory addresses of the device variables
//	int *device_a1_address, *device_a2_address, *device_result_address;
//
//	//allocating the memory in the device and storing the memory in the above pointer variables
//	//we will also assign the return of the memory allocated function to the cudaerror variables
//	error = cudaMalloc((int**)&device_a1_address, array_byte_size);
//	if (error != cudaSuccess)
//		fprintf(stderr, "%s\n", cudaGetErrorString(error));
//
//	error = cudaMalloc((int**)&device_a2_address, array_byte_size);
//	if (error != cudaSuccess)
//		fprintf(stderr, "%s\n", cudaGetErrorString(error));
//
//	error = cudaMalloc((int**)&device_result_address, array_byte_size);
//	if (error != cudaSuccess)
//		fprintf(stderr, "%s\n", cudaGetErrorString(error));
//
//	//after decleration of the array, copying the values from the host variable to the device variables
//	cudaMemcpy(device_a1_address, a1, array_byte_size, cudaMemcpyHostToDevice);
//	cudaMemcpy(device_a2_address, a2, array_byte_size, cudaMemcpyHostToDevice);
//
//	//declaring the grid and block variables
//	int block_size = 128;
//	dim3 block(block_size);
//	dim3 grid((array_size/block_size+1));
//
//	//launch of the kernel function
//	array_summation_2 <<< grid, block>>> (device_a1_address, device_a2_address, device_result_address, array_byte_size);
//	cudaDeviceSynchronize();
//	cudaMemcpy(result, device_result_address, array_byte_size, cudaMemcpyDeviceToHost);
//
//	//validate the cuda generated result by CPU generated result
//	c_results = (int*)malloc(array_byte_size);
//	array_summation_2_cpu(a1, a2, c_results, array_size);
//
//	//validation function
//	array_summation_2_validation(c_results, result, array_size);
//
//	return 0;
//}