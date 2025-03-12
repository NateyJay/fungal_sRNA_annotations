#!/bin/bash

mkdir ../annotations/Vedah.PRJNA819185
cd ../annotations/Vedah.PRJNA819185

echo Vedah.PRJNA819185


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA819185.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR18490847:A SRR18490848:A SRR18490849:A SRR18490853:B SRR18490856:B SRR18490857:B -a /scratch/njohnson/Vedah.PRJNA819185.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vedah.PRJNA819185.bam
rm /scratch/njohnson/Vedah.PRJNA819185.bam.bai
rm /scratch/njohnson/Vedah.PRJNA819185.depth.txt



