#!/bin/bash

mkdir ../annotations/Scpom.PRJNA235985
cd ../annotations/Scpom.PRJNA235985

echo Scpom.PRJNA235985.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




