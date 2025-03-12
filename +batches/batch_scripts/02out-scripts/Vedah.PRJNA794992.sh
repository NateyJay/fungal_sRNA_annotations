#!/bin/bash

mkdir ../annotations/Vedah.PRJNA794992
cd ../annotations/Vedah.PRJNA794992

echo Vedah.PRJNA794992


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Vedah.PRJNA794992.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR17460083:A SRR17460084:A SRR17460085:A -a /scratch/njohnson/Vedah.PRJNA794992.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Vedah.PRJNA794992.bam
rm /scratch/njohnson/Vedah.PRJNA794992.bam.bai
rm /scratch/njohnson/Vedah.PRJNA794992.depth.txt



