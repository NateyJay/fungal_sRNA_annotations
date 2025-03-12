#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350506
cd ../annotations/Scpom.PRJNA350506

echo Scpom.PRJNA350506


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350506.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR4449756:A SRR4449757:A SRR4449760:A SRR4449761:A SRR4449764:A SRR4449765:A SRR4449758:B SRR4449759:B SRR4449762:B SRR4449763:B SRR4449766:B SRR4449767:B -a /scratch/njohnson/Scpom.PRJNA350506.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA350506.bam
rm /scratch/njohnson/Scpom.PRJNA350506.bam.bai
rm /scratch/njohnson/Scpom.PRJNA350506.depth.txt



