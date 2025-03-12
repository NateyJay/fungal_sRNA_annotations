#!/bin/bash

mkdir ../annotations/Scpom.PRJNA120293
cd ../annotations/Scpom.PRJNA120293

echo Scpom.PRJNA120293.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




