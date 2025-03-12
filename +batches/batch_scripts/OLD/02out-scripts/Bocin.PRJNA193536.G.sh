#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536.G

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA193536.G.bam
yasma.py tradeoff -o . -n G -ac G -a /scratch/njohnson/Bocin.PRJNA193536.G.bam
rm /scratch/njohnson/Bocin.PRJNA193536.G.bam



