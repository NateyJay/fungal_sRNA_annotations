#!/bin/bash

mkdir ../annotations/Tratr.PRJNA508370
cd ../annotations/Tratr.PRJNA508370

echo Tratr.PRJNA508370.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




