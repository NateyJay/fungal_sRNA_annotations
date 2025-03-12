#!/bin/bash

mkdir ../annotations/Fugra.PRJNA248275
cd ../annotations/Fugra.PRJNA248275

echo Fugra.PRJNA248275.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




