#!/bin/bash

mkdir ../annotations/Clros.PRJEB43636
cd ../annotations/Clros.PRJEB43636

echo Clros.PRJEB43636.F

echo "
annotating..."

cp ./align/alignment.bam /scratch/njohnson/Clros.PRJEB43636.F.bam
yasma.py tradeoff -o . -n F -ac F -a /scratch/njohnson/Clros.PRJEB43636.F.bam
rm /scratch/njohnson/Clros.PRJEB43636.F.bam



