#!/bin/bash

mkdir ../annotations/Bebas.PRJNA647702
cd ../annotations/Bebas.PRJNA647702

echo Bebas.PRJNA647702.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




