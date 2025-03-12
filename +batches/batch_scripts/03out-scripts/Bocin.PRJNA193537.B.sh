#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193537
cd ../annotations/Bocin.PRJNA193537

echo Bocin.PRJNA193537.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




