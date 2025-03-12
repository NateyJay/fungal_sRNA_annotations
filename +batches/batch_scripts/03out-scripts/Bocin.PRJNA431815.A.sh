#!/bin/bash

mkdir ../annotations/Bocin.PRJNA431815
cd ../annotations/Bocin.PRJNA431815

echo Bocin.PRJNA431815.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




