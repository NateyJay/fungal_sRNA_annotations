#!/bin/bash

mkdir ../annotations/Gimar.PRJEB35457
cd ../annotations/Gimar.PRJEB35457

echo Gimar.PRJEB35457.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




