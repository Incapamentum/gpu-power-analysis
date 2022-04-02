#include "../definitions.cuh"
#include "matmul.cuh"

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

int main(void)
{
    float a[WIDTH * WIDTH], b[WIDTH * WIDTH], c[WIDTH * WIDTH];
    int i;

    for (i = 0; i < (WIDTH * WIDTH); i++)
    {
        a[i] = 5;
        b[i] = 5;
        c[i] = 0;
    }

    matrixMultiplication(c, a, b, WIDTH);

    return 0;
}