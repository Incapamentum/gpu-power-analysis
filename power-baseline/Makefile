CUDA_ROOT = /usr/local/cuda-11

NVML_ROOT ?= $(CUDA_ROOT)
NVML_INC ?= $(CUDA_ROOT)/include
NVML_LIB ?= $(CUDA_ROOT)/lib64/stubs

NVCC = $(CUDA_ROOT)/bin/nvcc
NVCFLAGS = -L$(NVML_INC) -ccbin=$(CC)
CUDALIBS = -L$(NVML_LIB) -L$(CUDA_ROOT)/lib64 -lcuda -lcudart -lnvidia-ml -lstdc++

MM_CU = /home/goose/Workspaces/VS-Code/gpu-power-analysis/program_benchmarks/mm_mul/mm_mul.cu

mm_mul:
	$(NVCC) $(NVCFLAGD) $(INCLUDE) power_test.cu nvmlPower.cpp $(MM_CU) $(CUDALIBS)
	