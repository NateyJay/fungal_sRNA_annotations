#!/bin/bash

mkdir ../annotations/Blhor.PRJNA809109
cd ../annotations/Blhor.PRJNA809109

echo Blhor.PRJNA809109


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Blhor.PRJNA809109.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR18094628:A SRR18094629:A SRR18094630:A SRR18094632:B SRR18094633:B SRR18094631:B SRR18094644:C SRR18094643:C SRR18094634:C SRR18094637:D SRR18094636:D SRR18094635:D -a /scratch/njohnson/Blhor.PRJNA809109.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Blhor.PRJNA809109.bam
rm /scratch/njohnson/Blhor.PRJNA809109.bam.bai
rm /scratch/njohnson/Blhor.PRJNA809109.depth.txt



