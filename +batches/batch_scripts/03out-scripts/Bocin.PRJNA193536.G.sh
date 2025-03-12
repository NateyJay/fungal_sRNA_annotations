#!/bin/bash

mkdir ../annotations/Bocin.PRJNA193536
cd ../annotations/Bocin.PRJNA193536

echo Bocin.PRJNA193536.G


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n G -a tradeoff_G


echo "
"




