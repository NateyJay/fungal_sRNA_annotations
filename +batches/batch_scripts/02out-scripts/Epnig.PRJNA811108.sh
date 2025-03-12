#!/bin/bash

mkdir ../annotations/Epnig.PRJNA811108
cd ../annotations/Epnig.PRJNA811108

echo Epnig.PRJNA811108


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Epnig.PRJNA811108.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c SRR18163558:A SRR18163560:A SRR18163559:A -a /scratch/njohnson/Epnig.PRJNA811108.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Epnig.PRJNA811108.bam
rm /scratch/njohnson/Epnig.PRJNA811108.bam.bai
rm /scratch/njohnson/Epnig.PRJNA811108.depth.txt



