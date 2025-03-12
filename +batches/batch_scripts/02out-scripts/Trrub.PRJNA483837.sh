#!/bin/bash

mkdir ../annotations/Trrub.PRJNA483837
cd ../annotations/Trrub.PRJNA483837

echo Trrub.PRJNA483837


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Trrub.PRJNA483837.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR7630467:A SRR7630468:B -a /scratch/njohnson/Trrub.PRJNA483837.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Trrub.PRJNA483837.bam
rm /scratch/njohnson/Trrub.PRJNA483837.bam.bai
rm /scratch/njohnson/Trrub.PRJNA483837.depth.txt



