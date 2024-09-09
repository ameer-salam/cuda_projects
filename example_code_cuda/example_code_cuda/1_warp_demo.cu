//#include "cuda_runtime.h"
//#include "device_launch_parameters.h"
//
//#include <stdio.h>
//#include <stdlib.h>
//#include <random>
//
//__global__ void warp_demo()
//{
//	int gid = threadIdx.x + (blockIdx.x * blockDim.x) +
//		blockIdx.y + (gridDim.x * blockDim.x);
//	int warp_id = gid / 32;
//	int g_b_id = blockIdx.y * gridDim.x + blockIdx.x;
//	printf("threadIdx.x : %d\tblockIdx.x : %d\tblockIdx.y : %d\tgid : %d\twarp_id : %d\tgbid : %d\n",
//		threadIdx.x, blockIdx.x, blockIdx.y, gid, warp_id, g_b_id);
//
//}
//
//int main()
//{
//	dim3 block(42);
//	dim3 grid(2,2);
//	warp_demo << <grid, block>> > ();
//	return 0;
//}