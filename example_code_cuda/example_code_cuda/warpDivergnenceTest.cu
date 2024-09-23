#include <stdio.h>
#include <stdlib.h>

#include "cuda.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void no_divergence()
{
	int gid_of_thread = threadIdx.x + (blockIdx.x * blockDim.x);
	
	int warp_id_of_thread = gid_of_thread / 32;

	float a, b;
	a = b = 0;

	//here we will be diverging a warp and not a thread in a warp
	if (warp_id_of_thread % 2 == 0)
	{
		a = 100;
		b = 50.0;
	}
	else
	{
		a = 200;
		b = 75;
	}
}

__global__ void with_divergence()
{
	int gid_of_thread = threadIdx.x + (blockDim.x * blockIdx.x);

	float a, b;
	a = b = 0;


	//here we will be diverging the threads inside the warps
	if (gid_of_thread % 2 == 0)
	{
		a = 100;
		b = 50;
	}
	else
	{
		a = 200;
		b = 75;
	}
}

int main()
{
	printf("WARP DIVERGENCE EXAMPLE\n\n");


	dim3 grid();
	dim3 block(128);
}