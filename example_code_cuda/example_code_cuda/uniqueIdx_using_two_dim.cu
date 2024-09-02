#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>

__global__ void uniqueIdx_example(int* input)
{
	int tid = threadIdx.x;
	int offset = blockDim.x * blockIdx.x;
	int gid = tid + offset;
	printf("threadIdx.x : %d,\t blockIdx.x : %d,\tgid : %d,\tvalue : %d\n",
			threadIdx.x, blockIdx.x, gid, input[gid]);
}

//int main()
//{
//	int array_size = 10;
//	int array_byte_size = sizeof(int) * array_size;
//	int array[] = { 6,2,8,9,2,31,0,95, 1, 4 };
//
//	for (int i = 0; i < array_size; i++)
//	{
//		printf("%d  ", array[i]);
//	}
//	printf("\n\n");
//
//	int* a_data;
//	cudaMalloc((void**)&a_data, array_byte_size);
//	cudaMemcpy(a_data, array, array_byte_size, cudaMemcpyHostToDevice);
//
//	dim3 block(5);
//	dim3 grid(2);
//
//
//	uniqueIdx_example << <grid, block>> > (a_data);
//	return 0;
//}

//output
/*
6  2  8  9  2  31  0  95  1  4

threadIdx.x : 0,         blockIdx.x : 1,        gid : 5,        value : 31
threadIdx.x : 1,         blockIdx.x : 1,        gid : 6,        value : 0
threadIdx.x : 2,         blockIdx.x : 1,        gid : 7,        value : 95
threadIdx.x : 3,         blockIdx.x : 1,        gid : 8,        value : 1
threadIdx.x : 4,         blockIdx.x : 1,        gid : 9,        value : 4
threadIdx.x : 0,         blockIdx.x : 0,        gid : 0,        value : 6
threadIdx.x : 1,         blockIdx.x : 0,        gid : 1,        value : 2
threadIdx.x : 2,         blockIdx.x : 0,        gid : 2,        value : 8
threadIdx.x : 3,         blockIdx.x : 0,        gid : 3,        value : 9
threadIdx.x : 4,         blockIdx.x : 0,        gid : 4,        value : 2
*/