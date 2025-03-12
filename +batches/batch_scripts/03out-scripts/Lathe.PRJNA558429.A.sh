#!/bin/bash

mkdir ../annotations/Lathe.PRJNA558429
cd ../annotations/Lathe.PRJNA558429

echo Lathe.PRJNA558429.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




