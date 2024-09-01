#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include<stdio.h>

//kernel decleration
__global__ void threadIdx_example()
{
	printf("threadIdx.x=\t%d, threadIdx.y=\t%d, threadIdx.z=\t%d\n", threadIdx.x, threadIdx.y, threadIdx.z);
}

int main()
{
	int nx=16, ny = 16;
	dim3 block(8, 8);
	dim3 grid(nx/block.x, ny/block.y);
	threadIdx_example << <grid, block>> > ();
	cudaDeviceSynchronize();
	cudaDeviceReset();
	return 0;
}