#!/bin/bash

mkdir ../annotations/Bocin.PRJNA431815
cd ../annotations/Bocin.PRJNA431815

echo Bocin.PRJNA431815.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




