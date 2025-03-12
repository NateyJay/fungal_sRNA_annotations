#!/bin/bash

mkdir ../annotations/Asfla.PRJNA272148
cd ../annotations/Asfla.PRJNA272148

echo Asfla.PRJNA272148.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




