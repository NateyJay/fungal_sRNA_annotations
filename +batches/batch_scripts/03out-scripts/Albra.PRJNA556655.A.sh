#!/bin/bash

mkdir ../annotations/Albra.PRJNA556655
cd ../annotations/Albra.PRJNA556655

echo Albra.PRJNA556655.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




