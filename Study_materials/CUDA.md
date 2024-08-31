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
1. CUDA code consists of 
	1. Host Code (main function) - code that runs in CPU
	2. Device code - code which runs in GPU