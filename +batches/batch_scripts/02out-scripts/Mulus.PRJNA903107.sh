#!/bin/bash

mkdir ../annotations/Mulus.PRJNA903107
cd ../annotations/Mulus.PRJNA903107

echo Mulus.PRJNA903107


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Mulus.PRJNA903107.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F G H I J K L M N O P Q R S -c SRR22390019:A SRR22390021:B SRR22390022:C SRR22390023:D SRR22390024:E SRR22390035:F SRR22390036:G SRR22390037:H SRR22390038:I SRR22390039:J SRR22390041:K SRR22390042:L SRR22390043:M SRR22390044:N SRR22390045:O SRR22390046:P SRR22390047:Q SRR22390048:R SRR22390049:S -a /scratch/njohnson/Mulus.PRJNA903107.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Mulus.PRJNA903107.bam
rm /scratch/njohnson/Mulus.PRJNA903107.bam.bai
rm /scratch/njohnson/Mulus.PRJNA903107.depth.txt



