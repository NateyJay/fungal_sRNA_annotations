#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA760453
cd ../annotations/Fuoxy.PRJNA760453

echo Fuoxy.PRJNA760453


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA760453.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B C -c SRR15712226:B SRR15712225:B SRR15712227:B SRR15712232:C SRR15712233:C SRR15712234:C -a /scratch/njohnson/Fuoxy.PRJNA760453.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA760453.bam
rm /scratch/njohnson/Fuoxy.PRJNA760453.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA760453.depth.txt



