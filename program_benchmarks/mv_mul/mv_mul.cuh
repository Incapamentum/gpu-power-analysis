#ifndef MVMUL_CUH
#define MVMUL_CUH

__global__
void mv_mul(float *c, float *a, float *b, int n);

#endif