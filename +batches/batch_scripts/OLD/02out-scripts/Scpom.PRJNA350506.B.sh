#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350506
cd ../annotations/Scpom.PRJNA350506

echo Scpom.PRJNA350506.B

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350506.B.bam
yasma.py tradeoff -o . -n B -ac B -a /scratch/njohnson/Scpom.PRJNA350506.B.bam
rm /scratch/njohnson/Scpom.PRJNA350506.B.bam



