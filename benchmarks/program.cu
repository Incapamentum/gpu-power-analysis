#include "host/host.h"
#include "kernels/kernels.cuh"

#include "definitions.cuh"

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