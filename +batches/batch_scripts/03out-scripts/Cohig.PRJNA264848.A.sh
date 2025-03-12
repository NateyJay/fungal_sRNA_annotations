#!/bin/bash

mkdir ../annotations/Cohig.PRJNA264848
cd ../annotations/Cohig.PRJNA264848

echo Cohig.PRJNA264848.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




