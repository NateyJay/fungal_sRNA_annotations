#!/bin/bash

mkdir ../annotations/Putri.PRJNA266709
cd ../annotations/Putri.PRJNA266709

echo Putri.PRJNA266709.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




