#!/bin/bash

mkdir ../annotations/Scscl.PRJNA477286
cd ../annotations/Scscl.PRJNA477286

echo Scscl.PRJNA477286


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA477286.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E -c SRR7407892:A SRR7407904:A SRR7407905:A SRR7407908:B SRR7407907:B SRR7407906:B SRR7407903:C SRR7407909:C SRR7407902:C SRR7407896:D SRR7407899:D SRR7407898:D SRR7407900:E SRR7407901:E SRR7407893:E -a /scratch/njohnson/Scscl.PRJNA477286.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA477286.bam
rm /scratch/njohnson/Scscl.PRJNA477286.bam.bai
rm /scratch/njohnson/Scscl.PRJNA477286.depth.txt



