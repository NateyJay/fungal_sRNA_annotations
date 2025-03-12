#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB51338.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Clros.PRJEB51338.C.bam
rm /scratch/njohnson/Clros.PRJEB51338.C.bam



