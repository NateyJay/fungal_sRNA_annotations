#!/bin/bash

mkdir ../annotations/Nobom.PRJNA760284
cd ../annotations/Nobom.PRJNA760284

echo Nobom.PRJNA760284.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




