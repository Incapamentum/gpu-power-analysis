CUDA_ROOT = /usr/local/cuda-11
NVCC = $(CUDA_ROOT)/bin/nvcc

MM_CU = ../program_benchmarks/mm_mul/mm_mul.cu
MV_CU = ../program_benchmarks/mv_mul/mv_mul.cu

make:
	$(NVCC) power_test.cu $(MM_CU) $(MV_CU) -o power_test