#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




