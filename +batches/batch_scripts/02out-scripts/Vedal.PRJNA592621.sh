#!/bin/bash

mkdir ../annotations/Vedal.PRJNA592621
cd ../annotations/Vedal.PRJNA592621

echo Vedal.PRJNA592621


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vedal.PRJNA592621.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR10572981:A SRR10572980:B -a /scratch/njohnson/Vedal.PRJNA592621.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vedal.PRJNA592621.bam
rm /scratch/njohnson/Vedal.PRJNA592621.bam.bai
rm /scratch/njohnson/Vedal.PRJNA592621.depth.txt



