#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void blockIdx_example()
{
	printf("blockIdx.x : %d\tblockIdx.y : %d\tblockIdx.z : %d\n", blockIdx.x, blockIdx.y, blockIdx.z);
}

//int main()
//{
//	int nx = 16, ny = 16;
//	dim3 block(8, 8);
//	dim3 grid(nx / block.x, ny / block.y);
//	blockIdx_example << <grid, block>> > ();
//	cudaDeviceSynchronize();
//	cudaDeviceReset();
//	return 0;
//}