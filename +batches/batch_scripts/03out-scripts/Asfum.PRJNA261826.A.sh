#!/bin/bash

mkdir ../annotations/Asfum.PRJNA261826
cd ../annotations/Asfum.PRJNA261826

echo Asfum.PRJNA261826.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




