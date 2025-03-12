#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.D


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n D -a tradeoff_D


echo "
"




