#!/bin/bash

mkdir ../annotations/Scpom.PRJNA125397
cd ../annotations/Scpom.PRJNA125397

echo Scpom.PRJNA125397.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




