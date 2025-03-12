#!/bin/bash

mkdir ../annotations/Maory.PRJNA751253
cd ../annotations/Maory.PRJNA751253

echo Maory.PRJNA751253.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




