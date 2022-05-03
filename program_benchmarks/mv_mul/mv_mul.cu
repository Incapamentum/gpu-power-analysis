#include "mv_mul.cuh"

__global__
void mv_mul(float *c, float *a, float *b, int n)
{
    int j, row, sum = 0;

    row = threadIdx.x + blockDim.x * blockIdx.x;

    if (row < n)
        for (j = 0; j < n; j++)
            sum = sum + a[row * n + j] * b[j];

    c[row] = sum;
}