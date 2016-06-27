#! /bin/bash

set -e

if [[ "$CHEF_SOLO_JSON_PATH" != "" ]]; then
    chef-solo -c /chef/solo.rb -j $CHEF_SOLO_JSON_PATH
fi

if [[ "$DATA_COMPRESS" == "bz2" ]]; then
   tar cjvf /tmp/data.tar.bz2 -C /opt/osrm-data/$REGION/$PROFILE/ \
       $REGION$REGION_FILENAME_SUFFIX.osrm.core \
       $REGION$REGION_FILENAME_SUFFIX.osrm.datasource_names \
       $REGION$REGION_FILENAME_SUFFIX.osrm.datasource_indexes \
       $REGION$REGION_FILENAME_SUFFIX.osrm.edges \
       $REGION$REGION_FILENAME_SUFFIX.osrm.fileIndex \
       $REGION$REGION_FILENAME_SUFFIX.osrm.geometry \
       $REGION$REGION_FILENAME_SUFFIX.osrm.hsgr \
       $REGION$REGION_FILENAME_SUFFIX.osrm.icd \
       $REGION$REGION_FILENAME_SUFFIX.osrm.names \
       $REGION$REGION_FILENAME_SUFFIX.osrm.nodes \
       $REGION$REGION_FILENAME_SUFFIX.osrm.properties \
       $REGION$REGION_FILENAME_SUFFIX.osrm.ramIndex \
       $REGION$REGION_FILENAME_SUFFIX.osrm.timestamp
fi

if [[ "$STORAGE_FLAVOR" == "s3" ]]; then
   aws s3 cp /tmp/data.tar.bz2 s3://$AWS_S3_BUCKET$AWS_S3_BUCKET_PREFIX/$REGION/$PROFILE/$REGION-$PROFILE-`date +"%Y-%m-%d-%H-%M-%S"`-$OSRM_VERSION.tar.bz2
fi
