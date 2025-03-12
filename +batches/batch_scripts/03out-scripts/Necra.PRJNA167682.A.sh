#!/bin/bash

mkdir ../annotations/Necra.PRJNA167682
cd ../annotations/Necra.PRJNA167682

echo Necra.PRJNA167682.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




