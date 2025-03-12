#!/bin/bash

mkdir ../annotations/Culun.PRJNA769949
cd ../annotations/Culun.PRJNA769949

echo Culun.PRJNA769949.B


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n B -a tradeoff_B


echo "
"




