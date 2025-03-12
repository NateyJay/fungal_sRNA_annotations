#!/bin/bash

mkdir ../annotations/Fugra.PRJNA900007
cd ../annotations/Fugra.PRJNA900007

echo Fugra.PRJNA900007.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




