#!/bin/bash

mkdir ../annotations/Caalb.PRJNA715092
cd ../annotations/Caalb.PRJNA715092

echo Caalb.PRJNA715092


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA715092.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR14535487:A SRR14535484:A SRR14535488:A SRR14535480:B SRR14535479:B SRR14535478:B -a /scratch/njohnson/Caalb.PRJNA715092.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Caalb.PRJNA715092.bam
rm /scratch/njohnson/Caalb.PRJNA715092.bam.bai
rm /scratch/njohnson/Caalb.PRJNA715092.depth.txt



