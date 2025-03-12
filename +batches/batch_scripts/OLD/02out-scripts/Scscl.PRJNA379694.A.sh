#!/bin/bash

mkdir ../annotations/Scscl.PRJNA379694
cd ../annotations/Scscl.PRJNA379694

echo Scscl.PRJNA379694.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA379694.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Scscl.PRJNA379694.A.bam
rm /scratch/njohnson/Scscl.PRJNA379694.A.bam



