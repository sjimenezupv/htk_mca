#!/bin/bash
# 
# Step04_Recognition.sh
# Performs the recognition/classification of the test files
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022


#############################################################################
# Common variables in all the scripts #######################################
source Step99_Config.sh
#############################################################################


# 1st, we must create the grammar and the dictionary
# See http://www.labunix.uqam.ca/~boukadoum_m/DIC9315/Notes/Markov/HTK_basic_tutorial.pdf
#
# echo $HMM_RESULTS_DIR/HMM$n/CONTROL.hmm > hmmlist 
# echo $HMM_RESULTS_DIR/HMM$n/PACIENTE.hmm >> hmmlist 
#
# Parse the grammar to the file net.slf
# HParse -A -D -T 1 grammar net.slf


INIT_N=2
END_N=15

echo -e 'NUM_STATES \t HMM_IDX \t ACC' > $DIR_RESULTS/stats.train.txt
echo -e 'NUM_STATES \t HMM_IDX \t ACC' > $DIR_RESULTS/stats.test.txt

###########################################################################
# 4 - Results #############################################################
for st in $NUM_STATES
do

	for n in $(seq $INIT_N $END_N)
	do

	
		HMM_DIR1=$DIR_HMM/NumSt$st/HMM$n
		DIR_RESU=$DIR_RESULTS/Num$st
		
        # Debug
        echo '4 - #states' $st ' ['$n'/'$END_N'] -> HVite' 

		# Recognition		
        # Train list
		HVite -A -D -T 1 \
			  -C $HTK_CONFIG \
			  -H $HMM_DIR1/CONTROL.hmm \
			  -H $HMM_DIR1/PACIENTE.hmm \
			  -H $HMM_DIR1/vFloors \
			  -S $TRAIN_LIST  \
			  -i $DIR_RESU/reco.train.hmm$n.numSt$st.mlf  \
			  -w $DIR_CONF/net.slf \
				 $DIR_CONF/dict $DIR_CONF/units > /dev/null
		
        # Test list
		HVite -A -D -T 1 \
			  -C $HTK_CONFIG \
			  -H $HMM_DIR1/CONTROL.hmm \
			  -H $HMM_DIR1/PACIENTE.hmm \
			  -H $HMM_DIR1/vFloors \
			  -S $TEST_LIST  \
			  -i $DIR_RESU/reco.test.hmm$n.numSt$st.mlf  \
			  -w $DIR_CONF/net.slf \
				 $DIR_CONF/dict $DIR_CONF/units  > /dev/null

        # Debug
        echo '4 - #states' $st ' ['$n'/'$END_N'] -> HResults' 

        # Train list
		HResults -A -D -T 1 \
				 -I $TRAIN_MLF \
					$DIR_CONF/units \
					$DIR_RESU/reco.train.hmm$n.numSt$st.mlf  >  $DIR_RESU/results.train.hmm$n.numSt$st.txt 
					
        # Test list
		HResults -A -D -T 1 \
				 -I $TEST_MLF \
					$DIR_CONF/units \
					$DIR_RESU/reco.test.hmm$n.numSt$st.mlf  >  $DIR_RESU/results.test.hmm$n.numSt$st.txt 
		
        # Get the accuracies
		acc_train=$(cat $DIR_RESU/results.train.hmm$n.numSt$st.txt | grep Acc | cut -f 3 -d "=" | cut -f 1 -d " ")
		acc_testt=$(cat $DIR_RESU/results.test.hmm$n.numSt$st.txt  | grep Acc | cut -f 3 -d "=" | cut -f 1 -d " ")
	
        # Save the accuracies
		echo -e $st ' \t ' $n ' \t ' $acc_train  >> $DIR_RESULTS/stats.train.txt
		echo -e $st ' \t ' $n ' \t ' $acc_testt  >> $DIR_RESULTS/stats.test.txt
	done
done

echo 'Step04_Recognition.sh... [Done]'

