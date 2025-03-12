#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA329032
cd ../annotations/Fuoxy.PRJNA329032

echo Fuoxy.PRJNA329032.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA329032.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fuoxy.PRJNA329032.B.bam
rm /scratch/njohnson/Fuoxy.PRJNA329032.B.bam



