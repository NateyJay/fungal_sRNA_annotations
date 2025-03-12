#!/bin/bash

mkdir ../annotations/Bocin.PRJNA282705
cd ../annotations/Bocin.PRJNA282705

echo Bocin.PRJNA282705.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




