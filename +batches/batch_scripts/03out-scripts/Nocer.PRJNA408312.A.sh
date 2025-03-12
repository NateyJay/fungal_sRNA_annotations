#!/bin/bash

mkdir ../annotations/Nocer.PRJNA408312
cd ../annotations/Nocer.PRJNA408312

echo Nocer.PRJNA408312.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




