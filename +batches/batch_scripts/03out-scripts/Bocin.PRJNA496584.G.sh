#!/bin/bash

mkdir ../annotations/Bocin.PRJNA496584
cd ../annotations/Bocin.PRJNA496584

echo Bocin.PRJNA496584.G


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n G -a tradeoff_G


echo "
"




