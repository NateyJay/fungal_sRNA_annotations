#!/bin/bash

mkdir ../annotations/Asfla.PRJNA438019
cd ../annotations/Asfla.PRJNA438019

echo Asfla.PRJNA438019.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




