#!/bin/bash

mkdir ../annotations/Scpom.PRJNA278408
cd ../annotations/Scpom.PRJNA278408

echo Scpom.PRJNA278408.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




