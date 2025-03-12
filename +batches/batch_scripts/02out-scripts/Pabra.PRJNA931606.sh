#!/bin/bash

mkdir ../annotations/Pabra.PRJNA931606
cd ../annotations/Pabra.PRJNA931606

echo Pabra.PRJNA931606


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA931606.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR23341104:A SRR23341106:A SRR23341105:A SRR23341109:B SRR23341107:B SRR23341108:B SRR23341104:A SRR23341106:A SRR23341105:A SRR23341109:B SRR23341107:B SRR23341108:B -a /scratch/njohnson/Pabra.PRJNA931606.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pabra.PRJNA931606.bam
rm /scratch/njohnson/Pabra.PRJNA931606.bam.bai
rm /scratch/njohnson/Pabra.PRJNA931606.depth.txt



