#ifndef SAXPY_CUH
#define SAXPY_CUH

__global__
void saxpy(int n, float a, float *x, float *y);

#endif