#!/bin/bash

mkdir ../annotations/Vedal.PRJNA592621
cd ../annotations/Vedal.PRJNA592621

echo Vedal.PRJNA592621.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedal.PRJNA592621.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vedal.PRJNA592621.A.bam
rm /scratch/njohnson/Vedal.PRJNA592621.A.bam



