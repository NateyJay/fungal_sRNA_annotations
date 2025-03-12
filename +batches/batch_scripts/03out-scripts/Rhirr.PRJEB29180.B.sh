#!/bin/bash

mkdir ../annotations/Rhirr.PRJEB29180
cd ../annotations/Rhirr.PRJEB29180

echo Rhirr.PRJEB29180.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




