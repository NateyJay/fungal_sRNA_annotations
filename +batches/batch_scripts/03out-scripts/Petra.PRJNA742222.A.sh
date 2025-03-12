#!/bin/bash

mkdir ../annotations/Petra.PRJNA742222
cd ../annotations/Petra.PRJNA742222

echo Petra.PRJNA742222.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




