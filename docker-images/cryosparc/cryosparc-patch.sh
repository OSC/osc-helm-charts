#!/usr/bin/env bash

set -eE

mkdir -p $CRYOSPARC_DB_PATH 
rm -f run 

cryosparcm start 
cryosparcm status || true
cryosparcm patch --check 
cryosparcm patch --download 

tar xf cryosparc_master_patch.tar.gz -C /tmp/ cryosparc_master/patch 
patch_num=$(cat /tmp/cryosparc_master/patch)
echo Patch version found: $patch_num 

if [ "$patch_num" != "$PATCH" ]; then 
    echo "Patch version mismatch: $patch_num != $PATCH"
    exit 1
fi

cp -f cryosparc_master_patch.tar.gz /tmp/
