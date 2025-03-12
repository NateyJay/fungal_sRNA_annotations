#!/bin/bash

mkdir ../annotations/Plcor.PRJNA944818
cd ../annotations/Plcor.PRJNA944818

echo Plcor.PRJNA944818.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




