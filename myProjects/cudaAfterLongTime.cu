#include <iostream>
#include <cuda_runtime.h>

__global__ void sampleCUDAcode(){
	printf("this is from the thread  :  %d\n", (blockIdx.x * blockDim.x + threadIdx.x));
}

int main(){

	sampleCUDAcode<<<1024, 1024>>>();
	
	cudaDeviceSynchronize();
	return 0;
}
