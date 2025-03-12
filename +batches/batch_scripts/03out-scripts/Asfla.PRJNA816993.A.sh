#!/bin/bash

mkdir ../annotations/Asfla.PRJNA816993
cd ../annotations/Asfla.PRJNA816993

echo Asfla.PRJNA816993.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




