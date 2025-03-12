#!/bin/bash

mkdir ../annotations/Yalip.PRJNA964764
cd ../annotations/Yalip.PRJNA964764

echo Yalip.PRJNA964764.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




