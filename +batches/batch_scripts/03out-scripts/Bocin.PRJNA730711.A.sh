#!/bin/bash

mkdir ../annotations/Bocin.PRJNA730711
cd ../annotations/Bocin.PRJNA730711

echo Bocin.PRJNA730711.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




