#!/bin/bash
# 
# Step99_HHEd_Iteration.sh
# Performs an iteration with HHEd - Gaussian duplication
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022
#
# Parameters:
#
#   $1 - Initial HMM Index to Start

#############################################################################
# Arguments #################################################################
n=$1


#############################################################################
# Common variables in all the scripts #######################################
source Step99_Config.sh


#############################################################################
# 4 - Call to HHEd   ########################################################
echo -e '\t HHEd_Iteration... [Running]'
for st in $NUM_STATES
do

	i=$n
	j=$(expr $i - 1)
	
	echo '2 - HHEd -> #states ' $st ' ['$i'/'$n']' 
	
	HMM_DIR0=$DIR_HMM/NumSt$st/HMM$j
	HMM_DIR1=$DIR_HMM/NumSt$st/HMM$i
	DIR_RESU=$DIR_RESULTS/Num$st
	mkdir $HMM_DIR1

	HHEd -A -T 1  \
			 -C $HTK_CONFIG \
			 -H $HMM_DIR0/CONTROL.hmm \
			 -H $HMM_DIR0/PACIENTE.hmm \
			 -H $HMM_DIR0/vFloors \
			 -M $HMM_DIR1 \
				$DIR_CONF/edition01.hed \
				$DIR_CONF/units  >> $DIR_LOG/HHEd_Iteration.$st.$i.log
    
done

echo -e '\t HHEd_Iteration... [DONE]'
