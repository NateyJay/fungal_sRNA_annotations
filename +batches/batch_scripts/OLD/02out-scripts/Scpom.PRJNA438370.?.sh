#!/bin/bash

mkdir ../annotations/Scpom.PRJNA438370
cd ../annotations/Scpom.PRJNA438370

echo Scpom.PRJNA438370.?

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA438370.?.bam
yasma.py tradeoff -o . -n ? -ac ? -a /scratch/njohnson/Scpom.PRJNA438370.?.bam
rm /scratch/njohnson/Scpom.PRJNA438370.?.bam



