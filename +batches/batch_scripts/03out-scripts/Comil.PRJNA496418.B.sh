#!/bin/bash

mkdir ../annotations/Comil.PRJNA496418
cd ../annotations/Comil.PRJNA496418

echo Comil.PRJNA496418.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




