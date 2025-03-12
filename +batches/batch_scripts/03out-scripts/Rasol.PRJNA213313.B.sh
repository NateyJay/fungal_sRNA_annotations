#!/bin/bash

mkdir ../annotations/Rasol.PRJNA213313
cd ../annotations/Rasol.PRJNA213313

echo Rasol.PRJNA213313.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




