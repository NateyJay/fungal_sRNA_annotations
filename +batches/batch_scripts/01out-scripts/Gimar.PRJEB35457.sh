#!/bin/bash

mkdir ../annotations/Gimar.PRJEB35457
cd ../annotations/Gimar.PRJEB35457

echo Gimar.PRJEB35457


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs ERR3671191 ERR3671189 ERR3671190 \
--conditions ERR3671191:A ERR3671189:A ERR3671190:A \
--genome_file ../../Genomes/Gimar.GCA_009809945.1_UNITO_GmarBEG34_1.0_genomic.fa

echo "
downloading..."
yasma.py download -o .

echo "
finding adapters..."
yasma.py adapter -o .

echo "
trimming..."
yasma.py trim -o . --cores 28

echo "
aligning..."
yasma.py align -o . --cores 28


