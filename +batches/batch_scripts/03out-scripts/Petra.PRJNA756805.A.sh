#!/bin/bash

mkdir ../annotations/Petra.PRJNA756805
cd ../annotations/Petra.PRJNA756805

echo Petra.PRJNA756805.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




