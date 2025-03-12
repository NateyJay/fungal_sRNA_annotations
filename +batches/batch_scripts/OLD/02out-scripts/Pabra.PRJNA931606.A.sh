#!/bin/bash

mkdir ../annotations/Pabra.PRJNA931606
cd ../annotations/Pabra.PRJNA931606

echo Pabra.PRJNA931606.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA931606.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Pabra.PRJNA931606.A.bam
rm /scratch/njohnson/Pabra.PRJNA931606.A.bam



