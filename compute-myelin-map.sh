#!/bin/bash

set -x
set -e

t1=`jq -r '.t1' config.json`
t2=`jq -r '.t2' config.json`

[ ! -d ./output/ ] && mkdir -p output

[ ! -f ./output/map.nii.gz ] && wb_command -volume-math "clamp((T1w / T2w), 0, 100)" ./output/map.nii.gz -var T1w ${t1} -var T2w ${t2} -fixnan 0

if [ ! -f ./output/map.nii.gz ]; then
	echo "app failed. check logs"
	exit 1
else
	echo "app complete"
	exit 0
fi