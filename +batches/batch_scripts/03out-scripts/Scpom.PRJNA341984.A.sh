#!/bin/bash

mkdir ../annotations/Scpom.PRJNA341984
cd ../annotations/Scpom.PRJNA341984

echo Scpom.PRJNA341984.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




