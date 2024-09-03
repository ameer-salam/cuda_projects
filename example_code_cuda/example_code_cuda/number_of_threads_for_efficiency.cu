#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include <time.h>

__global__ void rando_number_(int* input, int size)
{
	int gid = threadIdx.x + (blockIdx.x * blockDim.x);
	if(gid < size)
	printf("threadIdx.x : %d.\tblockIdx.x : %d,\tgid : %d\tValue : %d\n", threadIdx.x, blockIdx.x, gid, input[gid]);
}

int main()
{
	int size = 150;
	int byte_size = size * sizeof(int);

	int* h_data;
	h_data = (int*)malloc(byte_size);

	time_t t;
	srand((unsigned)time(&t));
	for (int i = 0; i < size; i++)
		h_data[i] = (int)(rand() & 0xff);
	int* d_input;
	cudaMalloc((void**)&d_input, byte_size);
	cudaMemcpy(d_input, h_data, byte_size, cudaMemcpyHostToDevice);

	dim3 block(32);
	dim3 grid(5);

	rando_number_ << <grid, block >> > (d_input, size);

	cudaDeviceSynchronize();
	cudaDeviceReset();

	return 0;
}

