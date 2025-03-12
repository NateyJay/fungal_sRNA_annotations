#!/bin/bash

mkdir ../annotations/Cocin.PRJNA477255
cd ../annotations/Cocin.PRJNA477255

echo Cocin.PRJNA477255


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Cocin.PRJNA477255.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR7403493:A SRR7403495:A SRR7403494:A SRR7403496:B SRR7403497:B SRR7403498:B -a /scratch/njohnson/Cocin.PRJNA477255.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Cocin.PRJNA477255.bam
rm /scratch/njohnson/Cocin.PRJNA477255.bam.bai
rm /scratch/njohnson/Cocin.PRJNA477255.depth.txt



