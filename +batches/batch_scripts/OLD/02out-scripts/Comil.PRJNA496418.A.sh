#!/bin/bash

mkdir ../annotations/Comil.PRJNA496418
cd ../annotations/Comil.PRJNA496418

echo Comil.PRJNA496418.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Comil.PRJNA496418.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Comil.PRJNA496418.A.bam
rm /scratch/njohnson/Comil.PRJNA496418.A.bam



