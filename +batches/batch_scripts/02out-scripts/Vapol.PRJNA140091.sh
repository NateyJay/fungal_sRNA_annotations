#!/bin/bash

mkdir ../annotations/Vapol.PRJNA140091
cd ../annotations/Vapol.PRJNA140091

echo Vapol.PRJNA140091


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vapol.PRJNA140091.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR202951:A -a /scratch/njohnson/Vapol.PRJNA140091.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vapol.PRJNA140091.bam
rm /scratch/njohnson/Vapol.PRJNA140091.bam.bai
rm /scratch/njohnson/Vapol.PRJNA140091.depth.txt



