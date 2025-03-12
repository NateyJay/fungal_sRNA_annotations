#!/bin/bash

mkdir ../annotations/Caalb.PRJNA317629
cd ../annotations/Caalb.PRJNA317629

echo Caalb.PRJNA317629


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Caalb.PRJNA317629.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac C D -c SRR3344695:C SRR3344696:C SRR3344726:C SRR3344725:C SRR3344680:C SRR3344679:C SRR3344712:C SRR3344711:C SRR3344688:D SRR3344687:D SRR3344718:D SRR3344717:D SRR3344704:D SRR3344703:D SRR3344672:D SRR3344671:D -a /scratch/njohnson/Caalb.PRJNA317629.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Caalb.PRJNA317629.bam
rm /scratch/njohnson/Caalb.PRJNA317629.bam.bai
rm /scratch/njohnson/Caalb.PRJNA317629.depth.txt



