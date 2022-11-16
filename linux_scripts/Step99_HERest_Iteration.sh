#!/bin/bash
# 
# Step99_HERest_Iteration.sh
# Performs an iteration with HERest - Parameters reestimation
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022
#
# Parameters:
#
#   $1 - Initial HMM Index to Start
#   $2 - End     HMM Index to Finish

#############################################################################
# Arguments #################################################################
INIT_N=$1
END_N=$2


#############################################################################
# Common variables in all the scripts #######################################
source Step99_Config.sh


#############################################################################
# Reestimate all the models (different number of states)   ##################
echo -e '\t HERest_Iteration... [Running]'
for st in $NUM_STATES
do
	
	for i in $(seq $INIT_N $END_N)
	do
		j=$(expr $i - 1)
		
		echo '2 - HERest -> #states: ' $st ' ['$i'/'$END_N']' 
		
		HMM_DIR0=$DIR_HMM/NumSt$st/HMM$j
		HMM_DIR1=$DIR_HMM/NumSt$st/HMM$i
		DIR_RESU=$DIR_RESULTS/Num$st
		mkdir $HMM_DIR1
		
		HERest -A -D -T 1 \
		       -s $DIR_RESU/herest.$st.$i.stats \
			   -C $HTK_CONFIG \
			   -I $TRAIN_MLF \
			   -S $TRAIN_LIST \
			   -H $HMM_DIR0/CONTROL.hmm \
			   -H $HMM_DIR0/PACIENTE.hmm \
			   -H $HMM_DIR0/vFloors \
			   -L $DIR_DATA_LAB  \
			   -M $HMM_DIR1 \
			      $DIR_CONF/units >> $DIR_LOG/HERest_Iteration.$st.$i.log
	done
	
done

echo -e '\t HERest_Iteration... [DONE]'

