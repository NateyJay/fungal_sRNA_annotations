#!/bin/bash

mkdir ../annotations/Asfla.PRJNA816993
cd ../annotations/Asfla.PRJNA816993

echo Asfla.PRJNA816993.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




