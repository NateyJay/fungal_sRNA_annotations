#!/bin/bash

mkdir ../annotations/Pabra.PRJNA931606
cd ../annotations/Pabra.PRJNA931606

echo Pabra.PRJNA931606.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA931606.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Pabra.PRJNA931606.B.bam
rm /scratch/njohnson/Pabra.PRJNA931606.B.bam



