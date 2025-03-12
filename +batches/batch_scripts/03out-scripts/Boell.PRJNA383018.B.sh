#!/bin/bash

mkdir ../annotations/Boell.PRJNA383018
cd ../annotations/Boell.PRJNA383018

echo Boell.PRJNA383018.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




