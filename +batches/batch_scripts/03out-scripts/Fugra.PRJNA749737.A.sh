#!/bin/bash

mkdir ../annotations/Fugra.PRJNA749737
cd ../annotations/Fugra.PRJNA749737

echo Fugra.PRJNA749737.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




