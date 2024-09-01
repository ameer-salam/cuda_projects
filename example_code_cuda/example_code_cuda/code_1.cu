//#include "device_launch_parameters.h"
//#include "cuda_runtime.h"
//
//#include <stdio.h>
//
////declaring the kernel function
//__global__ void hello_cuda()
//{
//	printf("Hello CUDA!\n");
//}
//
//int main()
//{
//	//to print Hello CUDA! once
//	//hello_cuda << <1, 1 >> > ();s
//	//to print Hello CUDA! 30 times 
//	//we will run 30 threads in 1 block
//	hello_cuda << <1, 30 >> > ();
//	cudaDeviceSynchronize();
//
//
//	cudaDeviceReset();  //to reset the device and the memory too
//	return 0;
//}