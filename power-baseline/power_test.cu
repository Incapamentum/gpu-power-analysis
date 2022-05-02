#include "../program_benchmarks/definitions.cuh"
#include "../program_benchmarks/mm_mul/mm_mul.cuh"

#include "nvmlPower.hpp"

int main(void)
{
    dim3 Db = dim3(1);
    dim3 Dg = dim3(1);

    int n = 10;

    // Host variables
    float *a, *b, *c;

    // Device variables
    float *d_a, *d_b, *d_c;

    // Allocate host memory
    a = (float *)malloc(n * sizeof(float));
    b = (float *)malloc(n * sizeof(float));
    c = (float *)malloc(n * sizeof(float));

    // Allocate device memory
    cudaMalloc((void **)&d_a, n * sizeof(float));
    cudaMalloc((void **)&d_b, n * sizeof(float));
    cudaMalloc((void **)&d_c, n * sizeof(float));

    nvmlAPIRun();
    mm_mul<<<Db, Dg>>>(d_c, d_a, d_b, n);
    nvmlAPIEnd();

    // Freeing allocated memory
    free(a); free(b); free(c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

    return 0;
}