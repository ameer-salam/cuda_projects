//#include "cuda_runtime.h"
//#include "device_launch_parameters.h"
//
//#include<stdio.h>
//#include<stdlib.h>
//#include<random>
//
//
//
//int main()
//{
//	int device_count = 0; //variable to store the number of cuda enabled devices on the system
//	cudaGetDeviceCount(&device_count);
//	if (device_count == 0)
//		printf("No CUDA enabled devices found!\n");
//	else
//		printf("The number of CUDA enables devices avaiable are : %d\n", device_count);
//
//
//	//cuda get device properties function
//	int dev_no = 0;
//	cudaDeviceProp dProp;
//	cudaGetDeviceProperties(&dProp, dev_no);
//
//	//printing the device properties
//	printf("Device Name : %s\n", dProp.name);
//	printf("Number of multiprocessors : %d\n", dProp.multiProcessorCount);
//	printf("Clock rate : %d\n", dProp.clockRate);
//	printf("Compute capabillities : %d.%d kb\n", dProp.major, dProp.minor);
//	printf("Total Global Memory : %4.4f kb\n", dProp.totalGlobalMem/1024.0);
//	printf("Total Constant Memory : %4.4f kb\n", dProp.totalConstMem/1024.0);
//	printf("Total Shared memory per block : %4.4f kb\n", dProp.sharedMemPerBlock/1024.0);
//	printf("Total Shated memory per MP : %4.4f kb\n", dProp.sharedMemPerMultiprocessor / 1024.0);
//	printf("Total number of registers available per block : %d\n", dProp.regsPerBlock);
//	printf("Total number of registers available per MP : %d\n", dProp.regsPerMultiprocessor);
//	printf("Total number of threads available per block : %d\n", dProp.maxThreadsPerBlock);
//	printf("Total number of registers available per MP : %d\n", dProp.maxThreadsPerMultiProcessor);
//	printf("Wrap size : %d\n", dProp.warpSize);
//	printf("Maximum grid size : %d\n", dProp.maxGridSize);
//	printf("Maximum block dimension : %d\n", dProp.maxThreadsDim);
//	cudaDeviceReset();
//	return 0;
//}