#! /bin/bash

set -e

chef-solo -c /chef/solo.rb -j $CHEF_SOLO_JSON_PATH

tar cjvf /tmp/data.tar.bz2 -C /opt/osrm-data/$REGION/$PROFILE/ $REGION-latest.osrm.edges $REGION-latest.osrm.geometry $REGION-latest.osrm.names $REGION-latest.osrm.ramIndex $REGION-latest.osrm.fileIndex $REGION-latest.osrm.hsgr $REGION-latest.osrm.nodes

if [[ "$STORAGE_FLAVOR" == "s3" ]]; then
   aws s3 cp /tmp/data.tar.bz2 s3://$AWS_S3_BUCKET/$REGION-$PROFILE-`date +"%Y-%m-%d-%H-%M-%S"`-$OSRM_VERSION.tar.bz2
fi
