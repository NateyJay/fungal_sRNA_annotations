#!/bin/bash

mkdir ../annotations/Scpom.PRJNA154563
cd ../annotations/Scpom.PRJNA154563

echo Scpom.PRJNA154563.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




