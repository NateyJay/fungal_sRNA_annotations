

for DIR in `ls -d /Volumes/fungal_srnas/Annotations/*`; 
do

	echo $DIR

	if [ "${DIR}" != "/Volumes/fungal_srnas/Annotations/Fuoxy.PRJNA472169" ]; then
		yasma.py coverage -o $DIR
	fi
done

