#include "host.h"

#include "../kernels/kernels.cuh"

void matrixMultiplication(float *c, float *a, float *b, int n)
{
    int size;
    float *cd, *ad, *bd;

    size = n * n * sizeof(float);

    cudaMalloc((void **)&ad, size);
    cudaMemcpy(ad, a, size, cudaMemcpyHostToDevice);
    cudaMalloc((void **)&bd, size);
    cudaMemcpy(bd, b, size, cudaMemcpyHostToDevice);

    cudaMalloc((void **)*&cd, size);

    matmult<<<1, 1>>>(cd, ad, bd, n);

    cudaFree(cd);
    cudaFree(ad);
    cudaFree(bd);    
}