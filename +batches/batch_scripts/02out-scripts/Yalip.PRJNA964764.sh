#!/bin/bash

mkdir ../annotations/Yalip.PRJNA964764
cd ../annotations/Yalip.PRJNA964764

echo Yalip.PRJNA964764


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Yalip.PRJNA964764.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR24386479:A SRR24386478:A SRR24386477:A SRR24386483:B SRR24386485:B SRR24386484:B -a /scratch/njohnson/Yalip.PRJNA964764.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Yalip.PRJNA964764.bam
rm /scratch/njohnson/Yalip.PRJNA964764.bam.bai
rm /scratch/njohnson/Yalip.PRJNA964764.depth.txt



