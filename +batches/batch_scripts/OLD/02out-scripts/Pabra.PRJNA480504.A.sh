#!/bin/bash

mkdir ../annotations/Pabra.PRJNA480504
cd ../annotations/Pabra.PRJNA480504

echo Pabra.PRJNA480504.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA480504.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Pabra.PRJNA480504.A.bam
rm /scratch/njohnson/Pabra.PRJNA480504.A.bam



