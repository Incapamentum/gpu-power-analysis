#ifndef KERNEL_CUH
#define KERNEL_CUH

__global__
void matmult(float *c, float *a, float *b, int n);

#endif