#!/bin/bash

mkdir ../annotations/Bocin.PRJNA325479
cd ../annotations/Bocin.PRJNA325479

echo Bocin.PRJNA325479.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




