#!/bin/bash

mkdir ../annotations/Scpom.PRJNA122193
cd ../annotations/Scpom.PRJNA122193

echo Scpom.PRJNA122193.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




