#!/bin/bash

mkdir ../annotations/Fugra.PRJNA304218
cd ../annotations/Fugra.PRJNA304218

echo Fugra.PRJNA304218.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




