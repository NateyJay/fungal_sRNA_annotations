#!/bin/bash

mkdir ../annotations/Fuoxy.PRJNA329032
cd ../annotations/Fuoxy.PRJNA329032

echo Fuoxy.PRJNA329032.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




