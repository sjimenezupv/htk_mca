#!/bin/bash
# 
# Step01_float2htk.sh
# Converts .asc files to .mfc format (input for HTK)
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022

###########################################################################
# Common variables in all the scripts #####################################
source Step99_Config.sh
###########################################################################


echo '  FLOATS2HTK... [Running]'
for i in $(ls $DIR_DATA_ASC)
do

	id=${i%$suffixasc}
	ascfile=$id$suffixasc
	mfcfile=$id$suffixmfc
	
	ascpath=$DIR_DATA_ASC/$ascfile
	mfcpath=$DIR_DATA_MFC/$mfcfile
	
	# Get the #rows
	nr=$(wc -l $ascpath | cut -f1 -d' ')
	
	# Get the #columns
	nc=$(head -n 1 $ascpath | wc -w)
    
	# Debug
	echo -e '\tID:' $id '\t#rows:' $nr '\t#cols:' $nc

	# Convert format
	../bin/floats2htk $nc $nr  < $ascpath > $mfcpath
	
done

echo '  FLOATS2HTK... [Done]'
