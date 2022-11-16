#!/bin/bash
# 
# RunExperiment.sh
# Run the whole HTK experiment
# @author: Santiago Jiménez-Serrano [sanjiser at upv.es]
# @date:   2017-2022

###########################################################################

./Step01_float2htk.sh
./Step02_CreateMLF.sh
./Step03_CreateModels.sh
./Step04_Recognition.sh

###########################################################################