#!/bin/bash

mkdir ../annotations/Pugra.PRJNA960906
cd ../annotations/Pugra.PRJNA960906

echo Pugra.PRJNA960906.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




