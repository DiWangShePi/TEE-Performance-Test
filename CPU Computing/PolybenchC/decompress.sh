#!/bin/bash

mkdir Gramine
cd Gramine

mkdir datamining
cd datamining
mkdir correlation
mkdir covariance
cd ..

mkdir linear-algebra
cd linear-algebra
mkdir blas
cd blas
mkdir gemm
mkdir gemver
mkdir gesummv
mkdir symm
mkdir syr2k
mkdir syrk
mkdir trmm
cd ..
mkdir kernels
cd kernels
mkdir 2mm
mkdir 3mm
mkdir atax
mkdir bicg
mkdir doitgen
mkdir mvt
cd ..
mkdir solvers
cd solvers
mkdir cholesky
mkdir durbin
mkdir gramschmidt
mkdir lu
mkdir ludcmp
mkdir trisolv
cd ..
cd ..

mkdir medley
cd medley
mkdir deriche
mkdir floyd-warshall
mkdir nussinov
cd ..

mkdir stencils
cd stencils
mkdir adi
mkdir fdtd-2d
mkdir heat-3d
mkdir jacobi-1d
mkdir jacobi-2d
mkdir seidel-2d
cd ../..
