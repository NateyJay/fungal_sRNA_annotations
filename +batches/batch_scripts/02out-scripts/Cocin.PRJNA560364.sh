#!/bin/bash

mkdir ../annotations/Cocin.PRJNA560364
cd ../annotations/Cocin.PRJNA560364

echo Cocin.PRJNA560364


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA560364.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR9972093:A SRR9972091:A SRR9972092:A SRR9972088:B SRR9972090:B SRR9972089:B SRR9972086:C SRR9972087:C SRR9972094:C -a /scratch/njohnson/Cocin.PRJNA560364.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Cocin.PRJNA560364.bam
rm /scratch/njohnson/Cocin.PRJNA560364.bam.bai
rm /scratch/njohnson/Cocin.PRJNA560364.depth.txt



