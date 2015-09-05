#! /bin/bash

set -e

chef-solo -c /chef/solo.rb -j /chef/solo-osrm-data-chile.json

# TODO: compress
tar cjvf /tmp/data.tar.bz2 -C /opt/osrm-data/chile/bicycle/ chile-latest.osrm.edges chile-latest.osrm.geometry chile-latest.osrm.names chile-latest.osrm.ramIndex chile-latest.osrm.fileIndex chile-latest.osrm.hsgr chile-latest.osrm.nodes