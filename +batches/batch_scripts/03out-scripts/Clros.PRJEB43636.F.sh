#!/bin/bash

mkdir ../annotations/Clros.PRJEB43636
cd ../annotations/Clros.PRJEB43636

echo Clros.PRJEB43636.F


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n F -a tradeoff_F


echo "
"




