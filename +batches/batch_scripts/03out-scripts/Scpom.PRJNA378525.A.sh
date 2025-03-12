#!/bin/bash

mkdir ../annotations/Scpom.PRJNA378525
cd ../annotations/Scpom.PRJNA378525

echo Scpom.PRJNA378525.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




