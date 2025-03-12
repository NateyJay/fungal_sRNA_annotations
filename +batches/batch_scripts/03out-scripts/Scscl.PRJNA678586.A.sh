#!/bin/bash

mkdir ../annotations/Scscl.PRJNA678586
cd ../annotations/Scscl.PRJNA678586

echo Scscl.PRJNA678586.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




