#!/bin/bash

mkdir ../annotations/Zytri.PRJNA480952
cd ../annotations/Zytri.PRJNA480952

echo Zytri.PRJNA480952.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




