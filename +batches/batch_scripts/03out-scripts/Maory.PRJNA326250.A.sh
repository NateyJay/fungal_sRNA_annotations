#!/bin/bash

mkdir ../annotations/Maory.PRJNA326250
cd ../annotations/Maory.PRJNA326250

echo Maory.PRJNA326250.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




