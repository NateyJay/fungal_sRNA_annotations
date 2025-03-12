#!/bin/bash

mkdir ../annotations/Bocin.PRJNA978613
cd ../annotations/Bocin.PRJNA978613

echo Bocin.PRJNA978613.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




