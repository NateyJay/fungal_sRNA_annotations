#!/bin/bash

mkdir ../annotations/Clros.PRJEB43636
cd ../annotations/Clros.PRJEB43636

echo Clros.PRJEB43636


echo "
making inputs..."
yasma.py inputs \
-o . \
--srrs ERR5962536 ERR5962517 ERR5962331 ERR5962328 ERR5962325 ERR5962321 ERR5962320 ERR5962313 ERR5961861 ERR5961284 ERR5961277 ERR5961148 ERR5959764 ERR5959762 ERR5957080 ERR5956515 ERR5956514 ERR5956441 ERR5954367 ERR5954220 ERR5954218 ERR5954214 ERR5954182 ERR5952369 ERR5960091 ERR5960110 ERR5960111 ERR5961147 ERR5950791 ERR5950921 ERR5950930 ERR5950932 ERR5950923 ERR5950927 \
--conditions ERR5962536:Z.d2 ERR5962517:Z.d2 ERR5962331:Z.d2 ERR5962328:Z.d2 ERR5962325:Z.d2 ERR5962321:Z.d2 ERR5962320:X.d1 ERR5962313:X.d1 ERR5961861:X.d1 ERR5961284:X.d1 ERR5961277:X.d1 ERR5961148:X.d1 ERR5959764:Y.d2 ERR5959762:Y.d2 ERR5957080:Y.d2 ERR5956515:Y.d2 ERR5956514:Y.d2 ERR5956441:Y.d2 ERR5954367:W.d1 ERR5954220:W.d1 ERR5954218:W.d1 ERR5954214:W.d1 ERR5954182:W.d1 ERR5952369:W.d1 ERR5960091:C ERR5960110:C ERR5960111:C ERR5961147:C ERR5950791:F ERR5950921:F ERR5950930:F ERR5950932:F ERR5950923:F ERR5950927:F \
--genome_file ../../Genomes/Clros.GCA_902827195.2_C_rosea_IK726_genomic.fa

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


