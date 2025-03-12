#!/bin/bash

mkdir ../annotations/Scpom.PRJNA382810
cd ../annotations/Scpom.PRJNA382810

echo Scpom.PRJNA382810.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




