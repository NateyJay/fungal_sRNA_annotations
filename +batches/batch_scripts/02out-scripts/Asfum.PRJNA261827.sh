#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261827
cd ../annotations/Asfum.PRJNA261827

echo Asfum.PRJNA261827


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Asfum.PRJNA261827.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F G H -c SRR1583968:A SRR1583967:A SRR1583964:B SRR1583963:B SRR1583960:C SRR1583959:C SRR1583956:D SRR1583955:D SRR1583970:E SRR1583969:E SRR1583966:F SRR1583965:F SRR1583961:G SRR1583962:G SRR1583957:H SRR1583958:H -a /scratch/njohnson/Asfum.PRJNA261827.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Asfum.PRJNA261827.bam
rm /scratch/njohnson/Asfum.PRJNA261827.bam.bai
rm /scratch/njohnson/Asfum.PRJNA261827.depth.txt



