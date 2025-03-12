#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA722321
cd ../annotations/Rhirr.PRJNA722321

echo Rhirr.PRJNA722321.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




