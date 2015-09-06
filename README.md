# osrm-data-prepare-docker

## copy data.tar.bz2
```
id=$(docker run -e REGION=chile -e PROFILE=bicycle -d jpizarrom/osrm-data-prepare-docker)
docker wait $id
docker cp $id:/tmp/data.tar.bz2 . && mv data.tar.bz2 data-`date +"%Y-%m-%d-%H-%M-%S"`.tar.bz2
```

## upload to s3

```
docker run \
         -e REGION=chile \
         -e PROFILE=bicycle \
         -e STORAGE_FLAVOR=s3 \
         -e AWS_S3_BUCKET=... \
         -e AWS_ACCESS_KEY_ID=... \
         -e AWS_SECRET_ACCESS_KEY=... \
         -d osrm-data-docker
```
