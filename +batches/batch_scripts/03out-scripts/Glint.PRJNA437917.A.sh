#!/bin/bash

mkdir ../annotations/Glint.PRJNA437917
cd ../annotations/Glint.PRJNA437917

echo Glint.PRJNA437917.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




