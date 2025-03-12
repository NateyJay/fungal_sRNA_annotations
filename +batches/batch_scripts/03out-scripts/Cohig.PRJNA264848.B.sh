#!/bin/bash

mkdir ../annotations/Cohig.PRJNA264848
cd ../annotations/Cohig.PRJNA264848

echo Cohig.PRJNA264848.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




