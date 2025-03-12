#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA329032
cd ../annotations/Fuoxy.PRJNA329032

echo Fuoxy.PRJNA329032.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Fuoxy.PRJNA329032.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Fuoxy.PRJNA329032.A.bam
rm /scratch/njohnson/Fuoxy.PRJNA329032.A.bam



