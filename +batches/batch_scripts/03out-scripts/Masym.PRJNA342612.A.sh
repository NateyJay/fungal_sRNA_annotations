#!/bin/bash

mkdir ../annotations/Masym.PRJNA342612
cd ../annotations/Masym.PRJNA342612

echo Masym.PRJNA342612.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




