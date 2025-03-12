#!/bin/bash

mkdir ../annotations/Rhirr.PRJNA429556
cd ../annotations/Rhirr.PRJNA429556

echo Rhirr.PRJNA429556.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




