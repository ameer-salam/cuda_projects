#include <iostream>
#include <cuda_runtime.h>

__global__ void exampleCode(){
	printf("this is being printed from the thread : %d\n", (blockIdx.x * blockDim.x + threadIdx.x));
}

int main(){
	exampleCode<<<1024, 1024>>>();
	
	cudaDeviceSynchronize();
	return 0;
}
