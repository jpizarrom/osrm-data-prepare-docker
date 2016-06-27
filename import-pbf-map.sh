#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

readonly PBF_DOWNLOAD_URL=${PBF_DOWNLOAD_URL:-false}

source import.sh

function import_pbf_map() {
    local pbf_file="$1"
    drop_tables

    create_timestamp_history
    imposm3 import \
        -connection "$PG_CONNECT" \
        -mapping "$MAPPING_YAML" \
        -overwritecache \
        -cachedir "$IMPOSM_CACHE_DIR" \
        -read "$pbf_file" \
        -dbschema-import="${DB_SCHEMA}" \
        -write

    local timestamp=$(extract_timestamp "$pbf_file")
    store_timestamp_history "$timestamp"
}

function main() {
    if ! [ "$PBF_DOWNLOAD_URL" = false ]; then
        download_pbf "$PBF_DOWNLOAD_URL"
    fi

    if [ "$(ls -A $IMPORT_DATA_DIR/*.pbf 2> /dev/null)" ]; then
        local pbf_file
        for pbf_file in "$IMPORT_DATA_DIR"/*.pbf; do
            import_pbf_map "$pbf_file"
            break
        done
    else
        echo "No PBF files for import found."
        echo "Please mount the $IMPORT_DATA_DIR volume to a folder containing OSM PBF files."
        exit 404
    fi
}

main