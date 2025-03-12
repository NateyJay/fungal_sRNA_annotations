#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA213313
cd ../annotations/Rhirr.PRJNA213313

echo Rhirr.PRJNA213313.C


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n C -a tradeoff_C


echo "
"




