#!/bin/bash

mkdir ../annotations/Vedah.PRJNA819185
cd ../annotations/Vedah.PRJNA819185

echo Vedah.PRJNA819185.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA819185.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Vedah.PRJNA819185.B.bam
rm /scratch/njohnson/Vedah.PRJNA819185.B.bam



