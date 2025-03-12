#!/bin/bash

mkdir ../annotations/Pustr.PRJNA289147
cd ../annotations/Pustr.PRJNA289147

echo Pustr.PRJNA289147


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs SRR19441421 SRR19441424 SRR19441423 SRR19441422 SRR2094581 SRR2094580 SRR2094579 SRR2094492 SRR2094565 SRR2094566 \
--conditions SRR19441421:A SRR19441424:A SRR19441423:A SRR19441422:A SRR2094581:C SRR2094580:C SRR2094579:C SRR2094492:D SRR2094565:D SRR2094566:D \
--genome_file ../../Genomes/Pustr.GCF_021901695.1_Pst134E36_v1_pri_genomic.fa

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


