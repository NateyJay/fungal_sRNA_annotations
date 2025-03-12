#!/bin/bash

mkdir ../annotations/Pabra.PRJNA480504
cd ../annotations/Pabra.PRJNA480504

echo Pabra.PRJNA480504.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA480504.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Pabra.PRJNA480504.B.bam
rm /scratch/njohnson/Pabra.PRJNA480504.B.bam



