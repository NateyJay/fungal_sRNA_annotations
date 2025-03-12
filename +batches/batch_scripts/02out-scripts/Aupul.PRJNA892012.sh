#!/bin/bash

mkdir ../annotations/Aupul.PRJNA892012
cd ../annotations/Aupul.PRJNA892012

echo Aupul.PRJNA892012


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Aupul.PRJNA892012.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR21969908:A SRR21969907:A SRR21969906:A -a /scratch/njohnson/Aupul.PRJNA892012.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Aupul.PRJNA892012.bam
rm /scratch/njohnson/Aupul.PRJNA892012.bam.bai
rm /scratch/njohnson/Aupul.PRJNA892012.depth.txt



