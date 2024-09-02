//Print value of threadIdx, blockIdx, and gridDim variables for 3D grid which had 4 threads in all x, y, z dimensions and thread block size will be 2 threads in each dimension as well

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void exercise_program1()
{
	printf("threadIdx.x : %d\tthreadIdx.y : %d\tthreadIdx.z : %d\t -- blockIdx.x : %d\tblockIdx.y : %d\tblockIdx.z : %d\t--- gridDim.x : %d\tgridDim.y : %d\tgridDim.z : %d\n", threadIdx.x, threadIdx.y, threadIdx.z, blockIdx.x, blockIdx.y, blockIdx.z, gridDim.x, gridDim.y, gridDim.z);
}

//int main()
//{
//	dim3 block(2,2,2);
//	dim3 grid(2, 2, 2);
//	exercise_program1 << <grid, block>> > ();
//	cudaDeviceSynchronize();
//	cudaDeviceReset();
//	return 0;
//}