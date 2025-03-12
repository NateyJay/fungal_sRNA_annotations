#!/bin/bash

mkdir ../annotations/Necra.PRJNA350329
cd ../annotations/Necra.PRJNA350329

echo Necra.PRJNA350329.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




