#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA232807
cd ../annotations/Fuoxy.PRJNA232807

echo Fuoxy.PRJNA232807.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




