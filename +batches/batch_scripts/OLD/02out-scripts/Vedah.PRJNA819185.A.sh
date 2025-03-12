#!/bin/bash

mkdir ../annotations/Vedah.PRJNA819185
cd ../annotations/Vedah.PRJNA819185

echo Vedah.PRJNA819185.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA819185.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vedah.PRJNA819185.A.bam
rm /scratch/njohnson/Vedah.PRJNA819185.A.bam



