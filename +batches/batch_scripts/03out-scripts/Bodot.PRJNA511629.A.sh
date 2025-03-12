#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




