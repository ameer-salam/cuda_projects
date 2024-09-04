#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include<stdio.h>
#include<stdlib.h>
#include<random>


//kernel function
__global__ void array_summation_validation(int *a, int *b, int *c, int size)
{
	int gid = threadIdx.x + (blockIdx.x * blockDim.x);
	if (gid < size)
	{
		c[gid] = a[gid] + b[gid];
	}
}

void array_summation_validation_cpu(int* a_cpu, int* b_cpu, int* c_cpu, int size)
{
	for (int i = 0; i < size; i++)
	{
		c_cpu[i] = a_cpu[i] + b_cpu[i];
	}
}

void validation_function(int* gpu_result, int* cpu_result, int size)
{
	for (int i = 0; i < size; i++)
	{
		if (gpu_result[i] != cpu_result[i])
		{
			printf("Arrays are not Equal!\n");
			return;
		}
	}
	printf("\n\nthe arrays are same and VALIDATED!\n");
}

int main()
{
	int array_size = 1000;
	int array_byte_size = array_size * sizeof(int);
	//host pointer variables to store the values of the arrays
	int *a1, *a2, *results;

	//assigning memory space for the variables and storing the head address of the array of memory
	a1 = (int*)malloc(array_byte_size);
	a2 = (int*)malloc(array_byte_size);
	results = (int*)malloc(array_byte_size);

	//assigning memory space for the variables for CPU generated results
	int* result_cpu;//, *a2_cpu, * a1_cpu;

	//allocating memory location for the cpu generated arrays
	result_cpu = (int*)malloc(array_byte_size);
	//a2_cpu = (int*)malloc(array_byte_size);
	//results_cpu = (int*)malloc(array_byte_size);

	//rnadomly initialize the array with random function
	for (int i = 0; i < array_size; i++)
	{
		a1[i] = rand() % 100+1;
		a2[i] = rand() % 100 + 1;
	}

	//printing all the variables of a1 and a2
	for (int i = 0; i < array_size; i++)
	{
		printf("a1[%d] = %d\ta2[%d] = %d\n", i, a1[i], i, a2[i]);
	}
	printf("\n");

	//declaring pointer variables in host to store the address of the device variables
	int *device_a1_address, *device_a2_address, *device_result_address;

	//allocating memory in device for a1, a2, and results
	cudaMalloc((int**)&device_a1_address, array_byte_size);
	cudaMalloc((int**)&device_a2_address, array_byte_size);
	cudaMalloc((int**)&device_result_address, array_byte_size);

	//copying the  values for host variables to the device variables
	cudaMemcpy(device_a1_address, a1, array_byte_size, cudaMemcpyHostToDevice);
	cudaMemcpy(device_a2_address, a2, array_byte_size, cudaMemcpyHostToDevice);

	//grid and block dimensions
	int no_of_threads_per_block = 128;
	dim3 grid((array_size/no_of_threads_per_block + 1)); //+1 is to gaurantee that we will hae more grid than needed to avoid unwanted errors
	dim3 block(no_of_threads_per_block);

	//calling the kernel function
	array_summation_validation <<<grid, block>>> (device_a1_address, device_a2_address, device_result_address, array_size);
	cudaDeviceSynchronize();

	//performing CPU array calculation
	array_summation_validation_cpu(a1, a2, result_cpu, array_size);

	//after kernel execution, we have to transfer the results from device to the host
	cudaMemcpy(results, device_result_address, array_byte_size, cudaMemcpyDeviceToHost);

	//function to validate the CPU and GPU calculation
	validation_function(results, result_cpu, array_size);

	//freeing memory in Host and device (Resetting device)
	cudaFree(device_a1_address); cudaFree(device_a2_address); cudaFree(device_result_address);
	free(a1);					 free(a2);					  free(results);
	cudaDeviceReset();
	return 0;
}
