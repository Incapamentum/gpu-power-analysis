#include "kernels.cuh"

__global__
void matmult(float *c, float *a, float *b, int n)
{
    int row, col, k;
    float sum = 0.0f;

    row = blockIdx.y * blockDim.y + threadIdx.y;
    col = blockIdx.x * blockDim.x + threadIdx.x;

    for (k = 0; k < n; k++)
        sum += a[row * n + k] * b[k * n + col];

    c[row * n + col] = sum;
}