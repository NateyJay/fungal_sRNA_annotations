#!/bin/bash

mkdir ../annotations/Vedah.PRJNA794992
cd ../annotations/Vedah.PRJNA794992

echo Vedah.PRJNA794992.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




