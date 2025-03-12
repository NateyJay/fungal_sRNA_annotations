#!/bin/bash

mkdir ../annotations/Gimar.PRJEB35457
cd ../annotations/Gimar.PRJEB35457

echo Gimar.PRJEB35457


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Gimar.PRJEB35457.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A -c ERR3671191:A ERR3671189:A ERR3671190:A -a /scratch/njohnson/Gimar.PRJEB35457.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Gimar.PRJEB35457.bam
rm /scratch/njohnson/Gimar.PRJEB35457.bam.bai
rm /scratch/njohnson/Gimar.PRJEB35457.depth.txt



