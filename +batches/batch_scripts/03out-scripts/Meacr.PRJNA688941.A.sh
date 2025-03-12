#!/bin/bash

mkdir ../annotations/Meacr.PRJNA688941
cd ../annotations/Meacr.PRJNA688941

echo Meacr.PRJNA688941.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




