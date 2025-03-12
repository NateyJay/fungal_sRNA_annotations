#!/bin/bash

mkdir ../annotations/Scpom.PRJNA438370
cd ../annotations/Scpom.PRJNA438370

echo Scpom.PRJNA438370


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Scpom.PRJNA438370.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac ? -c SRR6837113:? SRR6837121:? SRR6837116:? SRR6837112:? SRR6837117:? SRR6837119:? SRR6837120:? SRR6837118:? SRR6837128:? SRR6837130:? SRR6837132:? SRR6837131:? SRR6837126:? SRR6837125:? SRR6837124:? SRR6837127:? SRR6837122:? SRR6837129:? SRR6837123:? SRR6837133:? SRR6837115:? SRR6837114:? -a /scratch/njohnson/Scpom.PRJNA438370.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Scpom.PRJNA438370.bam
rm /scratch/njohnson/Scpom.PRJNA438370.bam.bai
rm /scratch/njohnson/Scpom.PRJNA438370.depth.txt



