#include "../program_benchmarks/definitions.cuh"

#include "../program_benchmarks/mm_mul/mm_mul.cuh"
#include "../program_benchmarks/mv_mul/mv_mul.cuh"

#include <stdio.h>
#include <string.h>

void matrixMultiplication(float *c, float *a, float *b, int n)
{
    float *c_dev, *a_dev, *b_dev;
    int size;

    size = n * n * sizeof(float);

    cudaMalloc((void **)&a_dev, size);
    cudaMemcpy(a_dev, a, size, cudaMemcpyHostToDevice);
    cudaMalloc((void **)&b_dev, size);
    cudaMemcpy(b_dev, b, size, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&c_dev, size);

    mm_mul<<<1, 1>>>(c_dev, a_dev, b_dev, n);

    cudaFree(c_dev);
    cudaFree(a_dev);
    cudaFree(b_dev);    
}

void matrixVectorMultiply(float *c, float *a, float *b, int n)
{
    float *a_dev, *b_dev, *c_dev;
    int size;

    size = n * sizeof(int);

    cudaMalloc((void **)&a_dev, size * size);
    cudaMalloc((void **)&b_dev, size);
    cudaMalloc((void **)&c_dev, size);

    cudaMemcpy(a_dev, a, size * size, cudaMemcpyHostToDevice);
    cudaMemcpy(b_dev, b, size, cudaMemcpyHostToDevice);

    mv_mul<<<1, 1>>>(a_dev, b_dev, c_dev, n);

    cudaFree(a_dev); cudaFree(b_dev); cudaFree(c_dev);
}

int main(int argc, char **argv)
{
    dim3 Db = dim3(1);
    dim3 Dg = dim3(1);

    int i, j, n = 10;

    // Host variables
    float *a, *b, *c;

    if (argc != 2)
    {
        printf("Insufficient arguments!\n");
        return -1;
    }

    a = (float *)malloc(n * n * sizeof(float));

    // Allocating memory for matrix-matrix
    if (strcmp("mm_mul", argv[1]) == 0)
    {
        b = (float *)malloc(n * n * sizeof(float));
        c = (float *)malloc(n * n * sizeof(float));

        for (i = 0; i < (n * n); i++)
        {
            a[i] = 5;
            b[i] = 5;
            c[i] = 0;
        }

        matrixMultiplication(c, a, b, n);
    }
    else if (strcmp("mv_mul", argv[1]) == 0)
    {
        b = (float *)malloc(n * sizeof(float));
        c = (float *)malloc(n * sizeof(float));

        for (i = 0; i < n; i++)
        {
            for (j = 0; j < n; j++)
            {
                a[i * n + j] = i * n + j + 1;
            }

            b[i] = i + 1;
        }

        matrixVectorMultiply(c, a, b, n);
    }

    // Freeing allocated memory
    free(a); free(b); free(c);

    return 0;
}