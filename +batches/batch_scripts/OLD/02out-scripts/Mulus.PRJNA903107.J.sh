#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.J

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.J.bam
yasma.py tradeoff -o . -n J -ac J -a /scratch/njohnson/Mulus.PRJNA903107.J.bam
rm /scratch/njohnson/Mulus.PRJNA903107.J.bam



