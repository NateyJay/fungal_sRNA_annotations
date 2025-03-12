#!/bin/bash

mkdir ../annotations/Nocer.PRJNA562787
cd ../annotations/Nocer.PRJNA562787

echo Nocer.PRJNA562787.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA562787.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Nocer.PRJNA562787.A.bam
rm /scratch/njohnson/Nocer.PRJNA562787.A.bam



