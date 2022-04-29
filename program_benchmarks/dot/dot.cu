#include "../definitions.cuh"
#include "dot.cuh"

__global__
void dot(int *a, int *b, int *c)
{
    int i, sum;
    __shared__ int temp[M_WIDTH];

    temp[threadIdx.x] = a[threadIdx.x] * b[threadIdx.x];

    __syncthreads();

    if (0 == threadIdx.x)
    {
        sum = 0;

        for (i = 0; i < M_WIDTH; i++)
            sum += temp[i];

        *c = sum;

    }
}