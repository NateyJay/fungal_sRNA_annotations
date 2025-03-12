#!/bin/bash

mkdir ../annotations/Asfla.PRJNA438019
cd ../annotations/Asfla.PRJNA438019

echo Asfla.PRJNA438019.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




