#!/bin/bash
# 
# Step99_Config.sh
# Contains the global variables for the scripts
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022

###########################################################################
# Common variables in all the scripts
DIR_ROOT=/mnt/w/BIOITACA/TESIS/2022/Tesis_Experimentacion/001_MCA/HTK_MCA_Tesis
DIR_DATA=$DIR_ROOT/data
DIR_DATA_ASC=$DIR_DATA/ASC
DIR_DATA_MFC=$DIR_DATA/MFC
DIR_DATA_LAB=$DIR_DATA/LAB
DIR_SCRIPTS=$DIR_ROOT/linux_scripts

DIR_CONF=$DIR_SCRIPTS/config
DIR_BIN=$DIR_SCRIPTS/bin
DIR_RESULTS=$DIR_SCRIPTS/results
DIR_HMM=$DIR_SCRIPTS/HMMFiles
DIR_LOG=$DIR_SCRIPTS/log


# HTK Configuration file. With the same TARGETKIND than the proto
HTK_CONFIG=$DIR_CONF/HTK.config

# List of encoded training files
TRAIN_LIST=$DIR_DATA/mfclist.train
TEST_LIST=$DIR_DATA/mfclist.test

# Master Label File (MLF) Files
TRAIN_MLF=$DIR_DATA/train.mlf
TEST_MLF=$DIR_DATA/test.mlf

# Variables and constants
VEC_SIZE=42    # Number of features (columns) in our data files
VAR_FLOOR=0.01 # Variance Floor

# Define the number of states that we will test
NUM_STATES=$(seq 20 5 60)

# File extensions
ascsuffix='.asc'
mfcsuffix='.mfc'
labsuffix='.lab'
suffixasc='.asc'
suffixmfc='.mfc'
suffixlab='.lab'
###########################################################################
