#!/bin/bash

mkdir ../annotations/Vapol.PRJNA140091
cd ../annotations/Vapol.PRJNA140091

echo Vapol.PRJNA140091.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vapol.PRJNA140091.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vapol.PRJNA140091.A.bam
rm /scratch/njohnson/Vapol.PRJNA140091.A.bam



