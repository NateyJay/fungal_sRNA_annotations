#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Bocin.PRJNA496584.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B C D E G -c SRR19164837:A SRR19164836:B SRR8074932:C SRR8074933:B SRR8074934:A SRR8074930:C SRR8074931:C SRR8074936:D SRR8074935:D SRR8074937:E SRR8074938:E SRR8074939:E SRR8074949:G SRR8074941:G SRR8074948:G -a /scratch/njohnson/Bocin.PRJNA496584.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Bocin.PRJNA496584.bam
rm /scratch/njohnson/Bocin.PRJNA496584.bam.bai
rm /scratch/njohnson/Bocin.PRJNA496584.depth.txt



