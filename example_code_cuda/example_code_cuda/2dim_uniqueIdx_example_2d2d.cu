#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


//for two dimensional grid
__global__ void thread_excersise_2d_2d(int* input)
{
	int tid = blockDim.x * threadIdx.y + threadIdx.x;

	int threads_in_block = blockDim.x * blockDim.y;
	int block_offset = (blockIdx.x * threads_in_block);

	int threads_in_row = threads_in_block * gridDim.x;
	int row_offset = threads_in_row * blockIdx.y;

	int gid = tid + (block_offset + row_offset);
	printf("threadIdx.x : %d,\t, blockIdx.x : %d,\tblockIdx.y : %d,\tgid : %d,\tvalue : %d\n", tid, blockIdx.x, blockIdx.y, gid, input[gid]);
}

//int main()
//{
//	int array[] = { 77,43,5,3,2,8,34,21,4,12,9, 54,234,12,54,89,34,12,34,64,3,12,76,34,9,54,23,65,54,12,59,22 };
//	int array_size = sizeof(array) / sizeof(int);
//	int array_byte_size = array_size * sizeof(int);
//	printf("The arrays size is : %d\nThe array byte size is : %d\nThe arrays is : \n", array_size, array_byte_size);
//	for (int i = 0; i < array_size; i++)
//		printf("%d\t", array[i]);
//	printf("\n");
//
//	dim3 block(2,2);
//	dim3 grid(4, 2);
//
//	int* d_array;
//	cudaMalloc((void**)&d_array, array_byte_size);
//	cudaMemcpy(d_array, array, array_byte_size, cudaMemcpyHostToDevice);
//
//	thread_excersise_2d_2d << <grid, block >> > (d_array);
//
//	return 0;
//
//}