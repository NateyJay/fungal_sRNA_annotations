#!/bin/bash

mkdir ../annotations/Scpom.PRJNA254525
cd ../annotations/Scpom.PRJNA254525

echo Scpom.PRJNA254525.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




