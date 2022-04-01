#ifndef KERNELS_CUH
#define KERNELS_CUH

__global__
void saxpy(int n, float a, float *x, float *y);

__global__
void matmult(float *c, float *a, float *b, int n);

#endif