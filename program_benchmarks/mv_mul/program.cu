#include "../definitions.cuh"
#include "mv_mul.cuh"

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

int main(void)
{
    int i, j;
    float *a, *b, *c;

    a = new float[N_WIDTH * N_WIDTH];
    b = new float[N_WIDTH];
    c = new float[N_WIDTH];

    for (i = 0; i < N_WIDTH; i++)
    {
        for (j = 0; j < N_WIDTH; j++)
        {
            a[i * N_WIDTH + j] = i * N_WIDTH + j + 1;
        }

        b[i] = i + 1;
    }

    matrixVectorMultiply(c, a, b, N_WIDTH);

    return 0;
}