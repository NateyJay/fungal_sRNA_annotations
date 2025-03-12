#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




