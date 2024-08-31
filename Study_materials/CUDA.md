* **Process** - is an instance of a computer program that is being executed.
* **Context** - data about the process which allows the processor to suspend or hold the execution of a process and restart the execution later.
* **Thread** - it is the smallest sequence of a programmed instruction that can be managed independently by a scheduler. Thread is a component of process and every process should have one thread known as a *main thread* which is the entry point for the program,

## Parallelism
1. **Task level Parallelism**
	1. Different Task on same or different data.
2. **Data level Parallelism**
	1. Same task on different data.

## Super computing, Heterogenous computing and GPU

* Performance of a Super computer is measured in **Floating point operations/Second**
* CPU v/s GPU

| CPU                                                              | GPU                                            |
| ---------------------------------------------------------------- | ---------------------------------------------- |
| High lock speed                                                  | Low lock speed                                 |
| Small cores                                                      | Thousand cores                                 |
| have branch predictors                                           | No branch predictor                            |
|                                                                  | GPU's have massively parallel architecture     |
| Context switching is done by the software                        | Context switching is done by the Hardware      |
| Threads stall in memory latency in L1 and L2 cache               | can switch between threads if one thread stall |
| Thread schedulers and Dispatch units are implemented by Hardware | Work item creation is done by Software         |
* **Heterogenous computing**
	* Systems which use more than one kind of CPU cores.


# CUDA
CUDA stands for **Compute Unified Device Architecture** is a parallel computing platform and API (**Application Program Interface**).
* The specialty of CUDA is it allows the GPU to be used as **General Purpose Computing units** - **GPGPU** - general purpose graphics processing units.


## Basic Elements of CUDA program
* How CUDA programs work?
1. we initialize the data from CPU,
2. transfer the data from CPU context to GPU context,
3. kernel launch with needed grid/block size,
4. Transfer the results from GPU context to CPU context,
5. reclaim the allocated memory from GPU and CPU.


1. CUDA code consists of 
	1. Host Code (main function) - code that runs in CPU
		1. The host code is responsible for
			1. Allocating and Deallocating memory on the CPU,
			2. Allocate and Deallocate memory on GPU,
			3. Transfer data from host memory to Device memory and vice-versa
			4. Kernel Launch (**Kernel** is a function what runs on the GPU) - defines the execution configuration with appropriate configuration (number of blocks and threads per block).
			5. Error Handling - After every Kernel/CUDA API call, it checks for errors,
			6. Synchronization - it ensures that CPU and GPU are in sync and the Device code is executed before the Host continues. 
			7. memory cleanup.
	2. Device code - code which runs in GPU

## Writing my first CUDA program
* To declare that the function is a CUDA program, we have to use any of the following keyword before the function declaration `__global__`, `__host__` , `__device__`  
* Every kernel should have a `void` as a return type to indicate that the function is returning nothing. *Note* - if you want to return any variables from the kernel, you have to do explicitly transfer them using CUDA runtime function calls.

* Calling the Kernel function from the main function
	* usually function calls will consists of identifiers and arguments list, whereas to call a kernel function we have to launch `kernel launch paraments` also.

### Kernel Launch Parameters
* the kernel launch parameters are written in `<<<>>>`
* here it consists of `<<<no of blocks, no of threads per block>>>` (we can specify upto four kernel launch parameters)
* calling kernels are **asynchronous** function calls means the function does not have to wait util the kernel execution finishes, so that a host code can execute the next instructions as soon as kernel launch is done.
* if we want the host code to wait unit the kernel code completes the execution then we have to use the `cudaDeviceSynchronize()` function
* 
```cpp
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
    hello_cuda <<<1, 1 >>> ();

    cudaDeviceSynchronize();
    cudaDeviceReset();  //to reset the device and the memory too
    return 0;
}
```
## Important concepts in CUDA programming
1. **GRID**
	1. grid is a collection of all the threads launched for a kernel.
2. **BLOCK**
	1. Threads in a grid are organized into groups known as thread blocks. -> this helps CUDA to sync and manage workloads without heavy performance penalties
when launching the kernel we mention the thread blocks and number of threads per block in the [[#Kernel Launch Parameters]]
* if we specify an integer digit as we have done above we have defined values for one dimension only.
* If we have to define a multi-dimensional grids and blocks using `dim3` variables


## dim3
* dim3 is a type/vector type variable in CUDA having x, y, z values initialized to 1.
* we can access values of each dimension using `.` operators like
```cpp
dim3 variable_name(1, 2, 3);
variable_name.x;
variable_name.y;
variable_name.z;
```

* If I want to print 'Hello CUDA!' 32 times, then I can arrange 32 threads into 8 blocks and each block containing 4 threads jut like this 
```cpp
hello_cuda << <8, 4>> > ();
cudaDeviceSynchronize();
```
its visual representation can be like

------------------------------------------------>x
| |Thread Block 1|      |Thread Block 2|      |Thread Block 3|      |Thread Block n-1|      |Thread Block 8|
| |4 Thread/block|     |4 Thread/block|      |4 Thread/block|      |4 Thread/block|         |4 Thread/block|
|
|
|
|
Y
this block will have dimension -> `x=4, y=1, z=1` -> `dim3 block(4,1,1)` -> this is actually the second parameter of the Kernel launch parameters.