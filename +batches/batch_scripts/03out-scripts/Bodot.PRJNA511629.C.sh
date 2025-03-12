#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




