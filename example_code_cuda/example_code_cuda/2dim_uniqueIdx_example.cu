#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>

//__global__ void 2dim_uniqueIdx_example()
//{
//	int tidx = threadIdx.x;
//	int tidy = threadIdx.y;
//	int offsetx = blockIdx.x * blockDim.x;
//	int offsety = blockIdx.y * blockDim.y;
//	int gidx = tidx + offsetx;
//	int gidy = tidy + offsety;
//	printf("threadIdx : %d,\t")
//}

__global__ void unique_grid_calculation_2d(int* input)
{
	int tid = threadIdx.x;
	//int offset = blockDim.x * blockIdx.x;
	int gid = gridDim.x * (blockIdx.y * blockDim.x) //first statement of exuation to calculate row offset
		+ (blockIdx.x * blockDim.x) //block offset
		+ tid; //threadId in block
	printf("block_idx : %d,\tblockIdx.y : %d,\tthreadIdx.x : %d,\t, gid : %d,\tdata : %d\n",
		blockIdx.x, blockIdx.y, tid, gid, input[gid]);
}

//int main()
//{
//	int array_size = 16;
//	int array_byte_size = sizeof(int) * array_size;
//	int data[] = { 6,39,1,3,53,0,32,25,76,4,23,12,05,65,21,1 };
//
//	int *d_data;
//	cudaMalloc((void**)&d_data, array_byte_size);
//	cudaMemcpy(d_data, data, array_byte_size, cudaMemcpyHostToDevice); 
//
//	dim3 block(4);
//	dim3 grid(2,2);
//
//	unique_grid_calculation_2d << <grid, block>> > (d_data);
//
//	cudaDeviceSynchronize();
//	cudaDeviceReset();
//	return 0;
//}