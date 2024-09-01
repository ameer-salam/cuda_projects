//#include "cuda_runtime.h"
//#include "device_launch_parameters.h"
//
//#include <stdio.h>
//
//__global__ void dim_var_ex()
//{
//	printf("Hello CUDA!\n");
//}
//
//int main()
//{
//	dim3 block(4, 1, 1);
//	dim3 grid(8, 1, 1);
//	dim_var_ex <<< grid, block >>>();
//
//	cudaDeviceSynchronize();
//
//	cudaDeviceReset();
//
//
//	return 0;
//}