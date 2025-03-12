#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA562097
cd ../annotations/Fuoxy.PRJNA562097

echo Fuoxy.PRJNA562097.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA562097.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fuoxy.PRJNA562097.A.bam
rm /scratch/njohnson/Fuoxy.PRJNA562097.A.bam



