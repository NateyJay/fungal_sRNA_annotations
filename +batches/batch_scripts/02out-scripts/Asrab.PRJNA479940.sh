#!/bin/bash

mkdir ../annotations/Asrab.PRJNA479940
cd ../annotations/Asrab.PRJNA479940

echo Asrab.PRJNA479940


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asrab.PRJNA479940.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E -c SRR12847934:A SRR12847935:A SRR12847938:B SRR12847939:B SRR12847941:C SRR12847940:C SRR12847945:D SRR12847944:D SRR12847949:E SRR12847948:E -a /scratch/njohnson/Asrab.PRJNA479940.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asrab.PRJNA479940.bam
rm /scratch/njohnson/Asrab.PRJNA479940.bam.bai
rm /scratch/njohnson/Asrab.PRJNA479940.depth.txt



