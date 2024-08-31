#include "device_launch_parameters.h"
#include "cuda_runtime.h"

#include <stdio.h>

//declaring the kernel function
__global__ void hello_cuda()
{
	printf("Hello CUDA!");
}

int main()
{
	hello_cuda << <1, 1 >> > ();
	cudaDeviceSynchronize();

	cudaDeviceReset();  //to reset the device and the memory too
	return 0;
}