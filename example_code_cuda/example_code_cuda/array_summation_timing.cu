#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdint.h>
#include <stdlib.h>
#include<time.h>
#include <random>

//this program is for CPU array summation
void cpu_array_summation(int *a, int *b, int *c, int size)
{
	for (int i = 0; i < size; i++)
		c[i] = a[i] + b[i];
}

__global__ void gpu_array_summation(int* a, int* b, int* c, int size)
{
	int gid = threadIdx.x + (blockDim.x * blockIdx.x);
	if (gid < size)
	{
		c[gid] = a[gid] + b[gid];
		//printf("%d\n", c[gid]);
	}
}

void cpu_gpu_data_validation(int *a, int *b, int size)
{
	int rand_idx = rand() % 100000;
	for (int i = 0; i < size; i++)
	{
		if (a[i] != b[i])
		{
			printf("\n\nALERT!\n!!RESULTANT ARRAYS NOT EQUAL!!\n\n");
			//bellow statement is for debugging
			printf("cpu_a[%d] = %d\tgpu[%d] = %d\n", rand_idx, a[rand_idx], rand_idx, b[rand_idx]);
			return;
		}
	}
	printf("Resultant arrays generated by CPU and GPU are completely identical!\nExample:\n");
	printf("cpu_a[%d] = %d\tgpu[%d] = %d\n\n", rand_idx, a[rand_idx], rand_idx, b[rand_idx]);
	rand_idx = rand() % 100000;
	printf("cpu_a[%d] = %d\tgpu[%d] = %d\n\n", rand_idx, a[rand_idx], rand_idx, b[rand_idx]);
}

int main()
{
	int array_size = 100000;
	int array_byte_size = array_size * sizeof(int);
	int *a1, *a2, *cpu_results, *gpu_results;
	cudaError error;

	//allocting memory on the host to accomodate these arrays
	//also calculating time for host variable memory allocation
	clock_t host_variable_allocation_start, host_variable_allocation_stop; //these variables will store the time taken in allocating the host variables
	host_variable_allocation_start = clock();
	a1 = (int*)malloc(array_byte_size);
	a2 = (int*)malloc(array_byte_size);
	cpu_results = (int*)malloc(array_byte_size);
	gpu_results = (int*)malloc(array_byte_size);
	host_variable_allocation_stop = clock();

	//using random function we will generate random elements for array size of 100000 
	//we will also calculate the time taken for generating and storing random vairables
	clock_t random_value_gen_and_assign_start, random_value_gen_and_assign_stop;
	random_value_gen_and_assign_start = clock();
	for (int i = 0; i < array_size; i++)
	{
		a1[i] = rand() % 10000 + 1;
		a2[i] = rand() % 10000 + 1;
	}
	random_value_gen_and_assign_stop = clock();

	//here we have declared pointer variables to store the memory addresses of the device variables
	//lets also count time taken for allocating memory at the device
	clock_t device_memory_allocation_start, device_memory_allocation_end;
	device_memory_allocation_start = clock();
	int *device_a1, *device_a2, *device_results;
	error = cudaMalloc((int**)&device_a1, array_byte_size);
			if (error != cudaSuccess)
			{
				fprintf(stderr, "%s\n", cudaGetErrorString(error));https://www.freepik.com/free-photos-vectors/white
			}
	error = cudaMalloc((int**)&device_a2, array_byte_size);
			if (error != cudaSuccess)
			{
				fprintf(stderr, "%s\n", cudaGetErrorString(error));
			}
	error = cudaMalloc((int**)&device_results, array_byte_size);
			if (error != cudaSuccess)
			{
				fprintf(stderr, "%s\n", cudaGetErrorString(error));
			}
	device_memory_allocation_end = clock();

	//now lets copy the array elements at host to the device
	//also while calculating the time
	clock_t time_for_data_host_to_device_start, time_for_data_host_to_device_stop;
	time_for_data_host_to_device_start = clock();
	error = cudaMemcpy(device_a1, a1, array_byte_size, cudaMemcpyHostToDevice);
			if (error != cudaSuccess)
			{
				fprintf(stderr, "%s\n", cudaGetErrorString(error));
			}
	error = cudaMemcpy(device_a2, a2, array_byte_size, cudaMemcpyHostToDevice);
			if (error != cudaSuccess)
			{
				fprintf(stderr, "%s\n", cudaGetErrorString(error));
			}
	time_for_data_host_to_device_stop = clock();

	//lets start CPU array summation
	//while also calculating the time for CPU to complete execution
	clock_t cpu_array_summation_start, cpu_array_summation_stop;
	cpu_array_summation_start = clock();
	cpu_array_summation(a1, a2, cpu_results, array_size);
	cpu_array_summation_stop = clock();

	//to calculate GPU timings we need cudaEventCreate
	cudaEvent_t g_start, g_stop;
	cudaEventCreate(&g_start);
	cudaEventCreate(&g_stop);

	//lets call kernel function and lets start the array summation at device (GPU)
	//also calculating GPU execution time
	int threads_each_block = 512;
	dim3 block(threads_each_block);
	dim3 grid((array_size / threads_each_block + 1));

	cudaEventRecord(g_start, 0);
	gpu_array_summation << <grid, block >> > (device_a1, device_a2, device_results, array_size);
	cudaEventRecord(g_stop, 0);

	cudaEventSynchronize(g_stop);

	float gpu_elappsedTime;
	cudaEventElapsedTime(&gpu_elappsedTime, g_start, g_stop);

	//cleaning up the events
	cudaEventDestroy(g_start);
	cudaEventDestroy(g_stop);

	//lets copy the results from Device to Host
	//calculate the time too
	clock_t time_for_data_device_to_host_start, time_for_data_device_to_host_stop;
	time_for_data_device_to_host_start = clock();
	error = cudaMemcpy(gpu_results, device_results, array_byte_size, cudaMemcpyDeviceToHost);
	if (error != cudaSuccess)
		fprintf(stderr, "%s\n", cudaGetErrorString(error));
	time_for_data_device_to_host_stop = clock();

	//lets validate if the data generated by CPU and GPU are same
	cpu_gpu_data_validation(cpu_results, gpu_results, array_size);


	printf("This program is to demonstrate how CPU and GPU differ in terms of Execution speed\nIn this program we will be adding two arrays of size 1,00,000 elements\n\n");
	printf("We will be comparing the time taken for the CPU and the GPU to complete the above task\n");
	printf("we will also calculate the time taken to move data from Host(CPU) to the Device(GPU) but this timing will be neglected\nas we are primarily focusing on the computing speed of CPU and GPU in parallel computing tasks\n\n\n");
	
	//lets calculate the time taken for each task
	printf("\n\nThe time taken for Host variables allovation is : %4.16f \n", (double)((double)(host_variable_allocation_stop - host_variable_allocation_start)/CLOCKS_PER_SEC));
	printf("The time taken for generating and assigning random values is : %4.16f \n", (double)((double)(random_value_gen_and_assign_stop - random_value_gen_and_assign_start) / CLOCKS_PER_SEC));
	printf("The time taken for pointer variables to hold address of device variables : %4.16f \n", (double)((double)(device_memory_allocation_end - device_memory_allocation_start) / CLOCKS_PER_SEC));
	printf("The time taken for copying host variables to device variable address : %4.16f \n", (double)((double)(time_for_data_host_to_device_stop - time_for_data_host_to_device_start) / CLOCKS_PER_SEC));
	printf("The time taken for copying results from device to host : %4.16f \n", (double)((double)(time_for_data_device_to_host_stop - time_for_data_device_to_host_start) / CLOCKS_PER_SEC));
	printf("The time taken for CPU array summation function : %4.16f \n", (double)((double)(cpu_array_summation_stop - cpu_array_summation_start) / CLOCKS_PER_SEC));
	printf("The time taken for GPU array summation function : %4.16f \n", gpu_elappsedTime); //(double)((double)(gpu_array_summation_stop - gpu_array_summation_start) / CLOCKS_PER_SEC)


	free(a1);		free(a2);		free(cpu_results);		free(gpu_results);
	cudaDeviceReset();
	return 0;
}