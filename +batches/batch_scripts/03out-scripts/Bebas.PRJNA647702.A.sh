#!/bin/bash

mkdir ../annotations/Bebas.PRJNA647702
cd ../annotations/Bebas.PRJNA647702

echo Bebas.PRJNA647702.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




