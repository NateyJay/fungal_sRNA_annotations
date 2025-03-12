#!/bin/bash

mkdir ../annotations/Scscl.PRJNA315516
cd ../annotations/Scscl.PRJNA315516

echo Scscl.PRJNA315516.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA315516.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA315516.A.bam
rm /scratch/njohnson/Scscl.PRJNA315516.A.bam



