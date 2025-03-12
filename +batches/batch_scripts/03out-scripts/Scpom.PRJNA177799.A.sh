#!/bin/bash

mkdir ../annotations/Scpom.PRJNA177799
cd ../annotations/Scpom.PRJNA177799

echo Scpom.PRJNA177799.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




