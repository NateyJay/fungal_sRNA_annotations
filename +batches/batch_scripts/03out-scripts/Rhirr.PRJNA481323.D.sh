#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA481323
cd ../annotations/Rhirr.PRJNA481323

echo Rhirr.PRJNA481323.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




