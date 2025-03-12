#!/bin/bash

mkdir ../annotations/Culun.PRJNA769949
cd ../annotations/Culun.PRJNA769949

echo Culun.PRJNA769949.A


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n A -a tradeoff_A


echo "
"




