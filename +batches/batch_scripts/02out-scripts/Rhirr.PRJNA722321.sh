#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhirr.PRJNA722321.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR14251176:A SRR14251177:A SRR14251175:A SRR14251174:A SRR14251179:B SRR14251181:B SRR14251180:B SRR14251178:B SRR14251182:C SRR14251183:C SRR14251184:C SRR14251185:D SRR14251187:D SRR14251186:D -a /scratch/njohnson/Rhirr.PRJNA722321.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhirr.PRJNA722321.bam
rm /scratch/njohnson/Rhirr.PRJNA722321.bam.bai
rm /scratch/njohnson/Rhirr.PRJNA722321.depth.txt



