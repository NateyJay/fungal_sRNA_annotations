#!/bin/bash

mkdir ../annotations/Pabra.PRJNA480504
cd ../annotations/Pabra.PRJNA480504

echo Pabra.PRJNA480504


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Pabra.PRJNA480504.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C -c SRR7505898:A SRR7505898:A SRR7505896:A SRR7505896:A SRR7505897:A SRR7505897:A SRR7505894:B SRR7505895:B SRR7505891:B SRR7505899:B SRR7505892:B SRR7505893:B SRR7505894:C SRR7505895:C SRR7505891:C SRR7505899:C SRR7505892:C SRR7505893:C -a /scratch/njohnson/Pabra.PRJNA480504.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Pabra.PRJNA480504.bam
rm /scratch/njohnson/Pabra.PRJNA480504.bam.bai
rm /scratch/njohnson/Pabra.PRJNA480504.depth.txt



