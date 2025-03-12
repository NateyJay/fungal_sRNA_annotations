#!/bin/bash

mkdir ../annotations/Fugra.PRJNA900007
cd ../annotations/Fugra.PRJNA900007

echo Fugra.PRJNA900007.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fugra.PRJNA900007.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Fugra.PRJNA900007.F.bam
rm /scratch/njohnson/Fugra.PRJNA900007.F.bam



