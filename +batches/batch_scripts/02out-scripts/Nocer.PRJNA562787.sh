#!/bin/bash

mkdir ../annotations/Nocer.PRJNA562787
cd ../annotations/Nocer.PRJNA562787

echo Nocer.PRJNA562787


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Nocer.PRJNA562787.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR10034571:A SRR10034573:A SRR10034572:A SRR10034578:B SRR10034570:B SRR10034579:B -a /scratch/njohnson/Nocer.PRJNA562787.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Nocer.PRJNA562787.bam
rm /scratch/njohnson/Nocer.PRJNA562787.bam.bai
rm /scratch/njohnson/Nocer.PRJNA562787.depth.txt



