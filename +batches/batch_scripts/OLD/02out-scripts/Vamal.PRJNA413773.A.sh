#!/bin/bash

mkdir ../annotations/Vamal.PRJNA413773
cd ../annotations/Vamal.PRJNA413773

echo Vamal.PRJNA413773.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Vamal.PRJNA413773.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Vamal.PRJNA413773.A.bam
rm /scratch/njohnson/Vamal.PRJNA413773.A.bam



