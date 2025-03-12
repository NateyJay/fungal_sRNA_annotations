#!/bin/bash

mkdir ../annotations/Fugra.PRJNA253153
cd ../annotations/Fugra.PRJNA253153

echo Fugra.PRJNA253153.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




