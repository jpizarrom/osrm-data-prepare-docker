#! /bin/bash

set -e

chef-solo -c /chef/solo.rb -j $CHEF_SOLO_JSON_PATH

tar cjvf /tmp/data.tar.bz2 -C /opt/osrm-data/$REGION/$PROFILE/ $REGION$REGION_FILENAME_SUFFIX.osrm.edges $REGION$REGION_FILENAME_SUFFIX.osrm.geometry $REGION$REGION_FILENAME_SUFFIX.osrm.names $REGION$REGION_FILENAME_SUFFIX.osrm.ramIndex $REGION$REGION_FILENAME_SUFFIX.osrm.fileIndex $REGION$REGION_FILENAME_SUFFIX.osrm.hsgr $REGION$REGION_FILENAME_SUFFIX.osrm.nodes

if [[ "$STORAGE_FLAVOR" == "s3" ]]; then
   aws s3 cp /tmp/data.tar.bz2 s3://$AWS_S3_BUCKET/$REGION-$PROFILE-`date +"%Y-%m-%d-%H-%M-%S"`-$OSRM_VERSION.tar.bz2
fi
