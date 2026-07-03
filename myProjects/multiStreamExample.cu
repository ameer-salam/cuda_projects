//this program is to see how the stream parallel execution works

#include <iostream>
#include <cuda_runtime.h>

__global__ void kernelExample1(){
	printf("K1 : thread Id : %d\n", (blockIdx.x * blockDim.x + threadIdx.x)); 
}

__global__ void kernelExample2(){
	printf("K2 : thread Id : %d\n", (blockIdx.x * blockDim.x + threadIdx.x)); 
}

int main(){
	cudaStream_t s1, s2;
	
	cudaStreamCreate(&s1);
	cudaStreamCreate(&s2);
	
	kernelExample1<<<1, 1024, 0, s1>>>();
	kernelExample2<<<1, 1024, 0, s2>>>();
	
	cudaDeviceSynchronize();
	return 0;
}
