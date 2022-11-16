#!/bin/bash
# 
# Step02_CreateMLF.sh
# Creates the Master Labels Files (MLF)
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022

###########################################################################
# Common variables in all the scripts #####################################
source Step99_Config.sh
###########################################################################


# 1 - Create the TRAIN_MLF file
echo -e 'Creating Master Label Files... [Running]'
echo -e '\t Creating train Master Label File: '$TRAIN_MLF

# Initialize the file
echo '#!MLF!#' > $TRAIN_MLF

# For each train file...
for i in $(cat $TRAIN_LIST)
do

	# Split dirs
	words=$(echo $i | tr "/" " ")
	
	# Get the last word
	for j in $words
	do
		id=$j
	done
	
	
	# Remove the .mfc suffix
	id=${id%$mfcsuffix}
	
	# Add the .lab suffix
	id=$id$labsuffix

	echo "\"*/$id\"" >> $TRAIN_MLF
	
	if [[ $i == *"PACIENTES"* ]]
	then
		w='PACIENTE'
	elif [[ $i == *"CONTROLES"* ]]
	then
		w='CONTROL'
	else
		w='UNKNOWN'
	fi
	
	echo $w >> $TRAIN_MLF
	echo $w >  $DIR_DATA_LAB/$id
	
	echo "." >> $TRAIN_MLF
done

# 1 - Create the TEST_MLF file
echo -e '\t  Creating test Master Label File: '$TEST_MLF

# Initialize the file
echo '#!MLF!#' > $TEST_MLF

# For each test file...
for i in $(cat $TEST_LIST)
do

	# Split dirs
	words=$(echo $i | tr "/" " ")
	
	# Get the last word
	for j in $words
	do
		id=$j
	done
	
	# Remove the .mfc suffix
	id=${id%$mfcsuffix}
	
	# Add the .lab suffix
	id=$id$labsuffix

	echo "\"*/$id\"" >> $TEST_MLF
	
	if [[ $i == *"PACIENTES"* ]]
	then
		w='PACIENTE'
	elif [[ $i == *"CONTROLES"* ]]
	then
		w='CONTROL'
	else
		w='UNKNOWN'
	fi
	
	echo $w >> $TEST_MLF
	echo $w >  $DIR_DATA_LAB/$id
	
	echo "." >> $TEST_MLF
done

echo 'Creating Master Label Files... [Done]'
