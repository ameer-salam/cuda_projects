//question
/*
imagine you have randomly initialized 64 elements array and you are going to 
pass this array to your device as well. Launch a 3D grid as shown below.

* grid - x=4, y=4, z=4
* block x=2, y=2, z=2
*/

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include <time.h>

__global__ void example2_function(int* input)
{
	int local_tid = threadIdx.x + (threadIdx.y * blockDim.x) + (threadIdx.z * blockDim.x * blockDim.y);
	int block_id = blockIdx.x + (blockIdx.y * gridDim.x) + (blockIdx.z * gridDim.x * gridDim.y);
	int grid = local_tid + (block_id * blockDim.x * blockDim.y * blockDim.z);
	printf("threadIdx.x : %d,\tthreadIdx.y : %d,\tthreadIdx.z : %d,\tblockId : %d,\tvalue : %d\n", threadIdx.x, threadIdx.y, threadIdx.z, block_id, input[grid]);
}

int main()
{
	int array_size = 64;
	int array_byte_size = array_size * sizeof(int);
	int array[] = {
	0, 1, 2, 3, 4, 5, 6, 7,
	8, 9, 10, 11, 12, 13, 14, 15,
	16, 17, 18, 19, 20, 21, 22, 23,
	24, 25, 26, 27, 28, 29, 30, 31,
	32, 33, 34, 35, 36, 37, 38, 39,
	40, 41, 42, 43, 44, 45, 46, 47,
	48, 49, 50, 51, 52, 53, 54, 55,
	56, 57, 58, 59, 60, 61, 62, 63
	};

	dim3 block(2, 2, 2);
	dim3 grid(2, 2, 2);
	int* d_data;

	cudaMalloc((void**)&d_data, array_byte_size);
	cudaMemcpy(d_data, array, array_byte_size, cudaMemcpyHostToDevice);

	example2_function <<<grid, block >>> (d_data);

	cudaDeviceSynchronize();
	cudaDeviceReset();

	return 0;
}