#include <time.h>

#include "../definitions.cuh"
#include "dot.cuh"

void dotProduct(int *a, int *b, int *c, int size)
{
    int *dev_a, *dev_b, *dev_c;

    cudaMalloc((void **)&dev_a, size);
    cudaMalloc((void **)&dev_b, size);
    cudaMalloc((void **)&dev_c, sizeof(int));

    cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);

    dot<<<1, 1>>>(dev_a, dev_b, dev_c);

    cudaFree(dev_a); cudaFree(dev_b); cudaFree(dev_c);
}

int main(void)
{
    int i;
    int *a, *b, *c;
    int size;

    size = DOT_ELEMENTS * sizeof(int);

    a = (int *)malloc(size);
    b = (int *)malloc(size);
    c = (int *)malloc(sizeof(int));

    srand(time(0));

    for (i = 0; i < DOT_ELEMENTS; i++)
    {
        a[i] = rand() % 100;
        b[i] = rand() % 100;
    }

    dotProduct(a, b, c, size);

    free(a); free(b); free(c);

    return 0;
}