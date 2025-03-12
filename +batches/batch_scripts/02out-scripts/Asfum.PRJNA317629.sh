#!/bin/bash

mkdir ../annotations/Asfum.PRJNA317629
cd ../annotations/Asfum.PRJNA317629

echo Asfum.PRJNA317629


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA317629.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR3344727:A SRR3344728:A SRR3344697:A SRR3344698:A SRR3344714:A SRR3344713:A SRR3344682:A SRR3344681:A SRR3344690:B SRR3344689:B SRR3344719:B SRR3344720:B SRR3344706:B SRR3344705:B SRR3344674:B SRR3344673:B -a /scratch/njohnson/Asfum.PRJNA317629.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfum.PRJNA317629.bam
rm /scratch/njohnson/Asfum.PRJNA317629.bam.bai
rm /scratch/njohnson/Asfum.PRJNA317629.depth.txt



