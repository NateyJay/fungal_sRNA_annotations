#!/bin/bash

mkdir ../annotations/Putri.PRJNA266709
cd ../annotations/Putri.PRJNA266709

echo Putri.PRJNA266709


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Putri.PRJNA266709.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR1646809:A SRR1646807:A -a /scratch/njohnson/Putri.PRJNA266709.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Putri.PRJNA266709.bam
rm /scratch/njohnson/Putri.PRJNA266709.bam.bai
rm /scratch/njohnson/Putri.PRJNA266709.depth.txt



