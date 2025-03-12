#!/bin/bash

mkdir ../annotations/Pabra.PRJNA480504
cd ../annotations/Pabra.PRJNA480504

echo Pabra.PRJNA480504.C

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA480504.C.bam
yasma.py tradeoff -o . -n C -ac C -a /scratch/njohnson/Pabra.PRJNA480504.C.bam
rm /scratch/njohnson/Pabra.PRJNA480504.C.bam



