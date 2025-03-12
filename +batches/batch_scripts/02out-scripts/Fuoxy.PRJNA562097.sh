#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA562097
cd ../annotations/Fuoxy.PRJNA562097

echo Fuoxy.PRJNA562097


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA562097.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR10020068:A SRR10020070:A SRR10020069:A -a /scratch/njohnson/Fuoxy.PRJNA562097.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Fuoxy.PRJNA562097.bam
rm /scratch/njohnson/Fuoxy.PRJNA562097.bam.bai
rm /scratch/njohnson/Fuoxy.PRJNA562097.depth.txt



