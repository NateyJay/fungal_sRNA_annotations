#!/bin/bash

mkdir ../annotations/Opsin.PRJNA673414
cd ../annotations/Opsin.PRJNA673414

echo Opsin.PRJNA673414


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Opsin.PRJNA673414.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR12952906:A SRR12952905:A SRR12952904:A SRR12952902:B SRR12952903:B SRR12952901:B SRR12952900:C SRR12952899:C SRR12952898:C -a /scratch/njohnson/Opsin.PRJNA673414.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Opsin.PRJNA673414.bam
rm /scratch/njohnson/Opsin.PRJNA673414.bam.bai
rm /scratch/njohnson/Opsin.PRJNA673414.depth.txt



