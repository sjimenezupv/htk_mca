#!/bin/bash
# 
# Step03_CreateModels.sh
# Creates the HMM Models (Initialize and train them)
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022

###########################################################################
# Common variables in all the scripts #####################################
source Step99_Config.sh
###########################################################################

###########################################################################
# 1 - Create the directories struct #######################################
rm -rf $DIR_HMM
rm -rf $DIR_LOG
rm -rf $DIR_RESULTS
mkdir  $DIR_HMM
mkdir  $DIR_LOG
mkdir  $DIR_RESULTS

for st in $NUM_STATES
do
	mkdir $DIR_HMM/NumSt$st
	mkdir $DIR_HMM/NumSt$st/HMM0
	mkdir $DIR_HMM/NumSt$st/HMM1
	mkdir $DIR_RESULTS/Num$st
	
	echo '0 - createHmmproto -> #states: ' $st
	
	HMM_DIR0=$DIR_HMM/NumSt$st/HMM0
	
	# Generate the initial hmm with the models for CONTROL and PACIENTE
	$DIR_BIN/createHmmproto $VEC_SIZE $st $HMM_DIR0/proto.hmm proto
done



###########################################################################
# 2 - Create the first model with HCompV for all the states ###############
for st in $NUM_STATES
do
	HMM_DIR0=$DIR_HMM/NumSt$st/HMM0
	HMM_DIR1=$DIR_HMM/NumSt$st/HMM1
	
	echo '1 - HCompV -> #states: ' $st
	
	# Call to HCompV
	#-L $DIR_DATA_LAB
	HCompV -C $HTK_CONFIG -f $VAR_FLOOR -m -S $TRAIN_LIST -I $TRAIN_MLF -M $HMM_DIR1 $HMM_DIR0/proto.hmm > $DIR_LOG/HCompV.log
	
	# Create 2 hmm. One for each LABEL, replacing 'proto' for the corresponding LABEL
	sed 's/proto/CONTROL/g'  $HMM_DIR0/proto.hmm > $HMM_DIR1/CONTROL.hmm
	sed 's/proto/PACIENTE/g' $HMM_DIR0/proto.hmm > $HMM_DIR1/PACIENTE.hmm	
	
done

#############################################################################


#############################################################################
# 3 - Reestimate all the models (different number of states)   ##############
# 1 Gaussian
./Step99_HERest_Iteration.sh 2 3

#############################################################################
# 4 - Again, reestimate all the models (different number of states) #########
#############################################################################

# 2 Gaussians
echo "MU 2 {*.state[2-4].mix}" > $DIR_CONF/edition01.hed
./Step99_HHEd_Iteration.sh 4           # Duplicate Gaussians
./Step99_HERest_Iteration.sh 5 6       # Reestimate parameters (3 iteraciones)

# 4 Gaussians
echo "MU 4 {*.state[2-4].mix}" > $DIR_CONF/edition01.hed
./Step99_HHEd_Iteration.sh 7           # Duplicate Gaussians
./Step99_HERest_Iteration.sh 8 9       # Reestimate parameters

# 8 Gaussians
echo "MU 8 {*.state[2-4].mix}" > $DIR_CONF/edition01.hed
./Step99_HHEd_Iteration.sh 10           # Duplicate Gaussians
./Step99_HERest_Iteration.sh 11 12      # Reestimate parameters

# 16 Gaussians
echo "MU 16 {*.state[2-4].mix}" > $DIR_CONF/edition01.hed
./Step99_HHEd_Iteration.sh 13           # Duplicate Gaussians
./Step99_HERest_Iteration.sh 14 15      # Reestimate parameters


# Debug finish
echo 'Step03_CreateModels.sh... [Done]'
