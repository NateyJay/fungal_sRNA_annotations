#!/bin/bash

mkdir ../annotations/Bodot.PRJNA511629
cd ../annotations/Bodot.PRJNA511629

echo Bodot.PRJNA511629.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




