#!/bin/bash

mkdir ../annotations/Bocin.PRJNA325479
cd ../annotations/Bocin.PRJNA325479

echo Bocin.PRJNA325479.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




