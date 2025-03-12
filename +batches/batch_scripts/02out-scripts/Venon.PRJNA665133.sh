#!/bin/bash

mkdir ../annotations/Venon.PRJNA665133
cd ../annotations/Venon.PRJNA665133

echo Venon.PRJNA665133


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Venon.PRJNA665133.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR12696055:A SRR12696056:A SRR12696047:A SRR12696051:B SRR12696052:B SRR12696053:B -a /scratch/njohnson/Venon.PRJNA665133.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Venon.PRJNA665133.bam
rm /scratch/njohnson/Venon.PRJNA665133.bam.bai
rm /scratch/njohnson/Venon.PRJNA665133.depth.txt



