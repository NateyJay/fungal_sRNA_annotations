#!/bin/bash

mkdir ../annotations/Zytri.PRJNA271281
cd ../annotations/Zytri.PRJNA271281

echo Zytri.PRJNA271281.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




