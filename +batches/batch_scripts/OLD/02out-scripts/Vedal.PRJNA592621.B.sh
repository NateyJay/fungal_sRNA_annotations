#!/bin/bash

mkdir ../annotations/Vedal.PRJNA592621
cd ../annotations/Vedal.PRJNA592621

echo Vedal.PRJNA592621.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedal.PRJNA592621.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Vedal.PRJNA592621.B.bam
rm /scratch/njohnson/Vedal.PRJNA592621.B.bam



