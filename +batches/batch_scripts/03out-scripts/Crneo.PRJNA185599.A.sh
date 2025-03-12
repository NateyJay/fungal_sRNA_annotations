#!/bin/bash

mkdir ../annotations/Crneo.PRJNA185599
cd ../annotations/Crneo.PRJNA185599

echo Crneo.PRJNA185599.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




