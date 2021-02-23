#!/bin/bash

set -x
set -e

t1=`jq -r '.t1' config.json`
t2=`jq -r '.t2' config.json`
reslice=`jq -r '.reslice' config.json`

[ ! -d ./output/ ] && mkdir -p output

[[ ${reslice} == 'true' ]] && mri_vol2vol --mov ${t2} --targ ${t1} --regheader --interp nearest --o ./t2.nii.gz && t2="./t2.nii.gz"

[ ! -f ./output/map.nii.gz ] && wb_command -volume-math "clamp((T1w / T2w), 0, 100)" ./output/map.nii.gz -var T1w ${t1} -var T2w ${t2} -fixnan 0

if [ ! -f ./output/map.nii.gz ]; then
	echo "app failed. check logs"
	exit 1
else
	echo "app complete"
	rm -rf *.nii.gz
	exit 0
fi
