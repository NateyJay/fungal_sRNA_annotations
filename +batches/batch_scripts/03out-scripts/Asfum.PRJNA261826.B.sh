#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




