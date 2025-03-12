#!/bin/bash

mkdir ../annotations/Plcor.PRJNA944818
cd ../annotations/Plcor.PRJNA944818

echo Plcor.PRJNA944818


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Plcor.PRJNA944818.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR23874486:A SRR23874487:A SRR23874485:A SRR23874488:B SRR23874489:B SRR23874490:B SRR23874493:C SRR23874491:C SRR23874492:C -a /scratch/njohnson/Plcor.PRJNA944818.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Plcor.PRJNA944818.bam
rm /scratch/njohnson/Plcor.PRJNA944818.bam.bai
rm /scratch/njohnson/Plcor.PRJNA944818.depth.txt



