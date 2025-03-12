#!/bin/bash

mkdir ../annotations/Vacer.PRJNA399493
cd ../annotations/Vacer.PRJNA399493

echo Vacer.PRJNA399493.?


echo "
size_profile..."
yasma.py size-profile -o . -a ./align/alignment.bam

# echo "
hairpin..."
# yasma.py hairpin -o . -n ? -a tradeoff_?


echo "
"




