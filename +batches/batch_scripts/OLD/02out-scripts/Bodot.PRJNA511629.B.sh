#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bodot.PRJNA511629.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Bodot.PRJNA511629.B.bam
rm /scratch/njohnson/Bodot.PRJNA511629.B.bam



