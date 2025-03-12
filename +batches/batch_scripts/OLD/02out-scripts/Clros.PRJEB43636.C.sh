#!/bin/bash

mkdir ../annotations/Clros.PRJEB43636
cd ../annotations/Clros.PRJEB43636

echo Clros.PRJEB43636.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB43636.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Clros.PRJEB43636.C.bam
rm /scratch/njohnson/Clros.PRJEB43636.C.bam



