#!/bin/bash

mkdir ../annotations/Trree.PRJNA201504
cd ../annotations/Trree.PRJNA201504

echo Trree.PRJNA201504.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Trree.PRJNA201504.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Trree.PRJNA201504.A.bam
rm /scratch/njohnson/Trree.PRJNA201504.A.bam



