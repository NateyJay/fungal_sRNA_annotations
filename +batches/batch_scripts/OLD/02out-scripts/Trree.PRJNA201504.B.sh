#!/bin/bash

mkdir ../annotations/Trree.PRJNA201504
cd ../annotations/Trree.PRJNA201504

echo Trree.PRJNA201504.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Trree.PRJNA201504.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Trree.PRJNA201504.B.bam
rm /scratch/njohnson/Trree.PRJNA201504.B.bam



