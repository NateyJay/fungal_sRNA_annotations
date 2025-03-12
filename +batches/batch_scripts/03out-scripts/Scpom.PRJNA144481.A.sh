#!/bin/bash

mkdir ../annotations/Scpom.PRJNA144481
cd ../annotations/Scpom.PRJNA144481

echo Scpom.PRJNA144481.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




