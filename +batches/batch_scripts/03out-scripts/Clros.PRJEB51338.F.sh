#!/bin/bash

mkdir ../annotations/Clros.PRJEB51338
cd ../annotations/Clros.PRJEB51338

echo Clros.PRJEB51338.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




