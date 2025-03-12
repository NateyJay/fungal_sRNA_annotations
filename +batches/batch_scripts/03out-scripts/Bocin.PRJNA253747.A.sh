#!/bin/bash

mkdir ../annotations/Bocin.PRJNA253747
cd ../annotations/Bocin.PRJNA253747

echo Bocin.PRJNA253747.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




