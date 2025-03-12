#!/bin/bash

mkdir ../annotations/Culun.PRJNA769949
cd ../annotations/Culun.PRJNA769949

echo Culun.PRJNA769949


echo "
copying alignment to scratch..."
cp ./align/alignment.bam /scratch/njohnson/Culun.PRJNA769949.bam

echo "
annotating..."
yasma.py tradeoff -o . -ac A B -c SRR16277948:A SRR16277950:B -a /scratch/njohnson/Culun.PRJNA769949.bam


echo "
deleting scratch alignment..."
rm /scratch/njohnson/Culun.PRJNA769949.bam
rm /scratch/njohnson/Culun.PRJNA769949.bam.bai
rm /scratch/njohnson/Culun.PRJNA769949.depth.txt



