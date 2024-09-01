#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void blockAndGrid_dim_example()
{
	printf("blockDim.x : %d\tblockDim.y : %d\tblockDim.z : %d\tgridDim.x : %d\tgridDim.y : %d\tgridDim.z : %d\n", blockDim.x, blockDim.y, blockDim.z, gridDim.x, gridDim.y, gridDim.z);
}

//int main()
//{
//	int nx, ny;
//	nx = 16, ny = 16;
//	dim3 block(8, 8);
//	dim3 grid(nx / block.x, ny / block.y);
//	blockAndGrid_dim_example << <grid, block >> > ();
//	cudaDeviceSynchronize();
//	cudaDeviceReset();
//	return 0;
//}