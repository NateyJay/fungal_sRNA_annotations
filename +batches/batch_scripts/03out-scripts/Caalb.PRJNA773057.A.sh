#!/bin/bash

mkdir ../annotations/Caalb.PRJNA773057
cd ../annotations/Caalb.PRJNA773057

echo Caalb.PRJNA773057.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




