#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107.M

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.M.bam
yasma.py tradeoff -o . -n M -ac M -a /scratch/njohnson/Mulus.PRJNA903107.M.bam
rm /scratch/njohnson/Mulus.PRJNA903107.M.bam



