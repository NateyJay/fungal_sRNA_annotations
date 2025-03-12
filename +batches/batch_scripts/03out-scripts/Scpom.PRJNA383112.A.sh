#!/bin/bash

mkdir ../annotations/Scpom.PRJNA383112
cd ../annotations/Scpom.PRJNA383112

echo Scpom.PRJNA383112.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




