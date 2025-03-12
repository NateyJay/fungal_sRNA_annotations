#!/bin/bash

mkdir ../annotations/Nobom.PRJNA953616
cd ../annotations/Nobom.PRJNA953616

echo Nobom.PRJNA953616.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




