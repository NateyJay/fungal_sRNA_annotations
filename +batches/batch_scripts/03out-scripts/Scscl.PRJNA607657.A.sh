#!/bin/bash

mkdir ../annotations/Scscl.PRJNA607657
cd ../annotations/Scscl.PRJNA607657

echo Scscl.PRJNA607657.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




