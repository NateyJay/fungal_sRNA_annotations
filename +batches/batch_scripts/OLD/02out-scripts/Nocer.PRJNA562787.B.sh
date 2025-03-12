#!/bin/bash

mkdir ../annotations/Nocer.PRJNA562787
cd ../annotations/Nocer.PRJNA562787

echo Nocer.PRJNA562787.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA562787.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Nocer.PRJNA562787.B.bam
rm /scratch/njohnson/Nocer.PRJNA562787.B.bam



