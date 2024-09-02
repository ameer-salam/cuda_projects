#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>

__global__ void uniqueIdx_call_threadIdx(int* input) //the aprameter is the pointer to the integer array
{
	int tid = threadIdx.x;
	printf("threadIdx: \t%d value: \t%d\n", tid, input[tid]);
}

//int main()
//{
//	int array_size = 8;
//	int array_byte_size = sizeof(int) * array_size;
//	int data[] = { 45,3,9,12,4,0,81,32 };
//
//	for (int i = 0; i < array_size; i++)
//	{
//		printf("%d  ", data[i]);
//	}
//	printf("\n");
//
//	int * a_data;
//	cudaMalloc((void**)&a_data, array_byte_size);
//	cudaMemcpy(a_data, data, array_byte_size, cudaMemcpyHostToDevice);
//
//	dim3 grid(1);
//	dim3 block(8);
//	uniqueIdx_call_threadIdx << <grid, block >> > (a_data);
//	cudaDeviceSynchronize();
//	cudaDeviceReset();
//	return 0;
//}