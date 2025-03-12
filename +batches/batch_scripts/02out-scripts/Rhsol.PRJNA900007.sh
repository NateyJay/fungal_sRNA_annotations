#!/bin/bash

mkdir ../annotations/Rhsol.PRJNA900007
cd ../annotations/Rhsol.PRJNA900007

echo Rhsol.PRJNA900007


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Rhsol.PRJNA900007.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac B C D E H -c SRR22252428:B SRR22252429:B SRR22252430:C SRR22252431:C SRR22252432:D SRR22252433:E SRR22252434:E SRR22252445:H SRR22252444:H -a /scratch/njohnson/Rhsol.PRJNA900007.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Rhsol.PRJNA900007.bam
rm /scratch/njohnson/Rhsol.PRJNA900007.bam.bai
rm /scratch/njohnson/Rhsol.PRJNA900007.depth.txt



