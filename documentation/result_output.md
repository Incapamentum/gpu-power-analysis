```/usr/local/cuda-11/bin/nvcc -L/usr/local/cuda-11/include -ccbin=cc  --keep -gencode arch=compute_75,code=sm_75 pipeline.cu  -L/usr/local/cuda-11/lib64/stubs -L/usr/local/cuda-11/lib64 -lcuda -lcudart -lnvidia-ml -lstdc++```

``` /usr/local/cuda-11/bin/nvcc -L/usr/local/cuda-11/include -ccbin=cc  -dryrun -gencode arch=compute_75,code=sm_75 pipeline.cu  -L/usr/local/cuda-11/lib64/stubs -L/usr/local/cuda-11/lib64 -lcuda -lcudart -lnvidia-ml -lstdc++ --keep 2>dryrun.out```

```nvcc -keep-dir=./intermediate/ -keep -gencode arch=compute_75,code=sm_75 add.cu add_test.cu```

```nvcc -ptx -gencode arch=compute_75,code=sm_75 add.cu add_test.cu```