#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA723916
cd ../annotations/Fuoxy.PRJNA723916

echo Fuoxy.PRJNA723916.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA723916.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Fuoxy.PRJNA723916.B.bam
rm /scratch/njohnson/Fuoxy.PRJNA723916.B.bam



