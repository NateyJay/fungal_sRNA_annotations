#!/bin/bash

mkdir ../annotations/Peita.PRJNA576793
cd ../annotations/Peita.PRJNA576793

echo Peita.PRJNA576793.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




