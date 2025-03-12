#!/bin/bash

mkdir ../annotations/Albra.PRJNA556655
cd ../annotations/Albra.PRJNA556655

echo Albra.PRJNA556655.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




