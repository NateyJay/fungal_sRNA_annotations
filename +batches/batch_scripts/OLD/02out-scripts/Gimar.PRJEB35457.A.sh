#!/bin/bash

mkdir ../annotations/Gimar.PRJEB35457
cd ../annotations/Gimar.PRJEB35457

echo Gimar.PRJEB35457.A

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Gimar.PRJEB35457.A.bam
yasma.py tradeoff -o . -n A -ac A -a /scratch/njohnson/Gimar.PRJEB35457.A.bam
rm /scratch/njohnson/Gimar.PRJEB35457.A.bam



