#!/bin/bash

mkdir ../annotations/Scscl.PRJNA348385
cd ../annotations/Scscl.PRJNA348385

echo Scscl.PRJNA348385


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scscl.PRJNA348385.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E -c SRR7407892:A SRR7407904:A SRR7407905:A SRR7407900:B SRR7407901:B SRR7407893:B SRR7407896:C SRR7407899:C SRR7407898:C SRR7407903:D SRR7407909:D SRR7407902:D SRR7407908:E SRR7407907:E SRR7407906:E -a /scratch/njohnson/Scscl.PRJNA348385.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scscl.PRJNA348385.bam
rm /scratch/njohnson/Scscl.PRJNA348385.bam.bai
rm /scratch/njohnson/Scscl.PRJNA348385.depth.txt



