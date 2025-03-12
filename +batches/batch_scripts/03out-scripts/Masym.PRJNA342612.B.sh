#!/bin/bash

mkdir ../annotations/Masym.PRJNA342612
cd ../annotations/Masym.PRJNA342612

echo Masym.PRJNA342612.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




