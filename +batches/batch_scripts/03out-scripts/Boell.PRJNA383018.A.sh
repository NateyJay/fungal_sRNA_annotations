#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




