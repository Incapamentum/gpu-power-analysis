#ifndef KERNELS_CUH
#define KERNELS_CUH

__global__
void saxpy(int n, float a, float *x, float *y);

__global__
void daxpy(int n, double a, double *x, double *y);

__global__
void mm_simple(float *c, float *a, float *b, int n);

#endif