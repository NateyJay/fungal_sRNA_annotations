#!/bin/bash

mkdir ../annotations/Scpom.PRJNA350403
cd ../annotations/Scpom.PRJNA350403

echo Scpom.PRJNA350403


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA350403.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E F -c SRR4449649:A SRR4449648:A SRR4449647:A SRR4449646:A SRR4449653:B SRR4449652:B SRR4449651:B SRR4449650:B SRR4449657:C SRR4449656:C SRR4449655:C SRR4449654:C SRR4449661:D SRR4449660:D SRR4449659:D SRR4449658:D SRR4449662:E SRR4449665:E SRR4449664:E SRR4449663:E SRR4449669:F SRR4449668:F SRR4449667:F SRR4449666:F -a /scratch/njohnson/Scpom.PRJNA350403.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA350403.bam
rm /scratch/njohnson/Scpom.PRJNA350403.bam.bai
rm /scratch/njohnson/Scpom.PRJNA350403.depth.txt



