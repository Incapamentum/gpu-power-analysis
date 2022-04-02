#ifndef KERNEL_CUH
#define KERNEL_CUH

__global__
void saxpy(int n, float a, float *x, float *y);

#endif