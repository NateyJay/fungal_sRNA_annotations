#!/bin/bash

mkdir ../annotations/Vedah.PRJNA198742
cd ../annotations/Vedah.PRJNA198742

echo Vedah.PRJNA198742.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA198742.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vedah.PRJNA198742.A.bam
rm /scratch/njohnson/Vedah.PRJNA198742.A.bam



