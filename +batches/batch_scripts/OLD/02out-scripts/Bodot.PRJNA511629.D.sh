#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.D

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bodot.PRJNA511629.D.bam
yasma.py tradeoff -o . -n D -ac D -a /scratch/njohnson/Bodot.PRJNA511629.D.bam
rm /scratch/njohnson/Bodot.PRJNA511629.D.bam



