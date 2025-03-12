#!/bin/bash

mkdir ../annotations/Vedah.PRJNA787244
cd ../annotations/Vedah.PRJNA787244

echo Vedah.PRJNA787244.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




