# nvcc -gencode arch=compute_75,code=compute_75 program.cu mv_mul.cu

CUDA_ROOT = /usr/local/cuda-11

ARCH_CC = 75
ARCH = arch=compute_$(ARCH_CC),code=compute_$(ARCH_CC)

NVCC = $(CUDA_ROOT)/bin/nvcc
CUOBJDUMP = $(CUDA_ROOT)/bin/cuobjdump

BENCHMARKS = dot mm_mul mv_mul saxpy
# FILES = $(foreach bench, $(BENCHMARKS), $(bench).cu)

# Generates PTX files from the above benchmarks
ptx:
	@for d in $(BENCHMARKS); do \
		echo "Compiiling $$d benchmark..."; \
		cd $$d; \
		mkdir ptx/; \
		$(NVCC) -gencode $(ARCH) $$d.cu program.cu; \
		$(CUOBJDUMP) a.out -xptx a.1; \
		mv *.ptx ./ptx/; \
		rm a.out; \
		cd ../; \
		echo " "; \
	done

	@echo "Completed!"

# Cleans the PTX files
clean:
	@echo "Cleaning up..."
	@for d in $(BENCHMARKS); do \
		cd $$d; \
		rm -r ./ptx/; \
		cd ../; \
	done

	@echo "Cleaned!"
