#!/bin/bash

mkdir ../annotations/Bocin.PRJNA978613
cd ../annotations/Bocin.PRJNA978613

echo Bocin.PRJNA978613


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA978613.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR24797115:A SRR24797116:A -a /scratch/njohnson/Bocin.PRJNA978613.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA978613.bam
rm /scratch/njohnson/Bocin.PRJNA978613.bam.bai
rm /scratch/njohnson/Bocin.PRJNA978613.depth.txt



