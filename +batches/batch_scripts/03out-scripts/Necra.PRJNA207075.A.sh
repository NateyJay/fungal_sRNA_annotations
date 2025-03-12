#!/bin/bash

mkdir ../annotations/Necra.PRJNA207075
cd ../annotations/Necra.PRJNA207075

echo Necra.PRJNA207075.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




