#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>

__global__ void array_summation(int *a, int *b, int *c, int size)
{
	int gid = threadIdx.x + (blockDim.x * blockIdx.x);
	if (gid < size)
	{
		c[gid] = a[gid] + b[gid];
	}
}

//int main()
//{
//	int array_size = 10;
//	int array_byte_size = array_size * sizeof(int);
//	
//	//declaring the host variables
//	int *a1, *a2, *result;
//	
//	//allocating memory space for a1, a2 and results variables
//	a1 = (int*)malloc(array_byte_size);
//	a2 = (int*)malloc(array_byte_size);
//	result = (int*)malloc(array_byte_size);
//
//	//generating random elements to feed into the a1 and a2 arrays
//	for (int i = 0; i < array_size; i++)
//	{
//		a1[i] = rand() % 100;
//		a2[i] = rand() % 100;
//	}
//	
//	//printing the arrays
//	for (int i = 0; i < array_size; i++)
//	{
//		printf("a1[%d] : %d\ta2[%d] : %d\n", i, a1[i], i, a2[i]);
//	}
//
//	//declaring pointer variabled to store the address of the device variables to access them
//	int *device_a1_pointer, *device_a2_pointer, *device_result_pointer;
//	
//	//allocating memory to hold the arrays and result in the device and returning the memory sequence pointers to the pointer variables above
//	cudaMalloc((int**)&device_a1_pointer, array_byte_size);
//	cudaMalloc((int**)&device_a2_pointer, array_byte_size);
//	cudaMalloc((int**)&device_result_pointer, array_byte_size);
//
//	//copying the data from the host variables to the device variables
//	cudaMemcpy(device_a1_pointer, a1, array_byte_size, cudaMemcpyHostToDevice);
//	cudaMemcpy(device_a2_pointer, a2, array_byte_size, cudaMemcpyHostToDevice);
//
//	dim3 grid(1);
//	dim3 block(array_size);
//
//	//calling the kernel
//	array_summation << <grid, block >> > (device_a1_pointer, device_a2_pointer, device_result_pointer, array_size);
//	cudaDeviceSynchronize();
//	
//	//after the kernel has executed copy the result from device to the host
//	cudaMemcpy(result, device_result_pointer, array_byte_size, cudaMemcpyDeviceToHost);
//
//	for (int i = 0; i < array_size; i++)
//		printf("a1[%d] + a2[%d] = %d\n", i, i, result[i]);
//
//	free(a1);
//	free(a2);
//	free(result);
//	free(device_a1_pointer);
//	free(device_a2_pointer);
//	free(device_result_pointer);
//	cudaDeviceReset();
//	return 0;
//}