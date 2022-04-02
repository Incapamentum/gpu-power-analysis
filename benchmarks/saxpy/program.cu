#include "../definitions.cuh"
#include "saxpy.cuh"

void singlePrecision(int n, float a, float *x, float *y)
{
    float *d_x, *d_y;

    cudaMalloc(&d_x, n * sizeof(float));
    cudaMemcpy(d_x, x, n * sizeof(float), cudaMemcpyHostToDevice);
    cudaMalloc(&d_y, n * sizeof(float));
    cudaMemcpy(d_y, y, n * sizeof(float), cudaMemcpyHostToDevice);

    // SAXPY on 1M elements
    saxpy<<<1, 1>>>(n, a, d_x, d_y);

    cudaFree(d_x);
    cudaFree(d_y);
}

int main(void)
{
    float *x, *y;
    int i;

    x = (float *)malloc(N * sizeof(float));
    y = (float *)malloc(N * sizeof(float));

    for (i = 0; i < N; i++)
    {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    singlePrecision(N, 2.0f, x, y);

    return 0;    
}
