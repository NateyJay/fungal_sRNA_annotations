#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Zytri.PRJNA480952.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D -c SRR7550260:A SRR7550250:A SRR7550251:A SRR7550275:B SRR7550277:B SRR7550276:B SRR7550272:C SRR7550273:C SRR7550274:C SRR7550270:D SRR7550271:D SRR7550279:D -a /scratch/njohnson/Zytri.PRJNA480952.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Zytri.PRJNA480952.bam
rm /scratch/njohnson/Zytri.PRJNA480952.bam.bai
rm /scratch/njohnson/Zytri.PRJNA480952.depth.txt



