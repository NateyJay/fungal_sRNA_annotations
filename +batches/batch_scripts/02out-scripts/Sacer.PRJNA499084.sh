#!/bin/bash

mkdir ../annotations/Sacer.PRJNA499084
cd ../annotations/Sacer.PRJNA499084

echo Sacer.PRJNA499084


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Sacer.PRJNA499084.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR8130772:A SRR8130771:A SRR8130770:A -a /scratch/njohnson/Sacer.PRJNA499084.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Sacer.PRJNA499084.bam
rm /scratch/njohnson/Sacer.PRJNA499084.bam.bai
rm /scratch/njohnson/Sacer.PRJNA499084.depth.txt



