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

__global__ void cuda_example_code(int* input)
{
	int tid = threadIdx.x + threadIdx.y;
	//int tidy = threadIdx.y;
	int threads_in_grid_row = blockDim.x * gridDim.x;
	int threads_in_grid_column = blockDim.y * gridDim.y;

	int block_offset = blockIdx.x * blockDim.x;
	int row_offset = blockId.y 
}

int main()
{

	cudaDeviceSynchronize();
	cudaDeviceReset();
	return 0;
}