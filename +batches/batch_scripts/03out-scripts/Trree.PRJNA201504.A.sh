#!/bin/bash

mkdir ../annotations/Trree.PRJNA201504
cd ../annotations/Trree.PRJNA201504

echo Trree.PRJNA201504.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




