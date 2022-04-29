#include "../definitions.cuh"
#include "mm_mul.cuh"

void matrixMultiplication(float *c, float *a, float *b, int n)
{
    int size;
    float *cd, *ad, *bd;

    size = n * n * sizeof(float);

    cudaMalloc((void **)&ad, size);
    cudaMemcpy(ad, a, size, cudaMemcpyHostToDevice);
    cudaMalloc((void **)&bd, size);
    cudaMemcpy(bd, b, size, cudaMemcpyHostToDevice);

    cudaMalloc((void **)&cd, size);

    mm_mul<<<1, 1>>>(cd, ad, bd, n);

    cudaFree(cd);
    cudaFree(ad);
    cudaFree(bd);    
}

int main(void)
{
    float a[M_WIDTH * M_WIDTH], b[M_WIDTH * M_WIDTH], c[M_WIDTH * M_WIDTH];
    int i;

    for (i = 0; i < (M_WIDTH * M_WIDTH); i++)
    {
        a[i] = 5;
        b[i] = 5;
        c[i] = 0;
    }

    matrixMultiplication(c, a, b, M_WIDTH);

    return 0;
}