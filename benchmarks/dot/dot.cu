#include "../definitions.cuh"
#include "kernel.cuh"

__global__
void dot(int *a, int *b, int *c)
{
    int i, sum;
    __shared__ int temp[M];

    temp[threadIdx.x] = a[threadIdx.x] * b[threadIdx.x];

    __syncthreads();

    if (0 == threadIdx.x)
    {
        sum = 0;

        for (i = 0; i < M; i++)
            sum += temp[i];

        *c = sum;

    }
}