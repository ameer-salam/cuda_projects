#include <stdio.h>
#include <stdlib.h>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void warp_div_ex()
{
	int gid = threadIdx.x;
	int warpId = gid / 32;
	int even, odd;
	if (warpId == 0)
	{
		even += 2;
	}
	else
		odd += 1;
		//printf("threadIdx.x : %d\tpresent in the warp : %d\n", gid, warpId);
}

//int main()
//{
//	dim3 grid(1);
//	dim3 block(64);
//
//	warp_div_ex <<<grid, block>> > ();
//	cudaDeviceSynchronize();
//	cudaDeviceReset();
//	return 0;
//}