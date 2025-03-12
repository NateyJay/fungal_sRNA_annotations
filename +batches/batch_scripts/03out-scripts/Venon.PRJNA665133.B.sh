#!/bin/bash

mkdir ../annotations/Venon.PRJNA665133
cd ../annotations/Venon.PRJNA665133

echo Venon.PRJNA665133.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




