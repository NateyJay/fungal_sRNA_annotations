#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bodot.PRJNA511629.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Bodot.PRJNA511629.A.bam
rm /scratch/njohnson/Bodot.PRJNA511629.A.bam



