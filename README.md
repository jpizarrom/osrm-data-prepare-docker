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
         -d jpizarrom/osrm-data-prepare-docker
```


## pollution

SELECT SUM(SQRT(area.area)) AS val FROM osm_ways way LEFT JOIN osm_landusages area ON ST_DWithin(way.geometry, area.geometry, 100) WHERE area.type IN ('industrial') AND way.osm_id=26409392 GROUP BY way.id;

SELECT SUM(SQRT(area.area)) AS val FROM osm_roads way LEFT JOIN osm_landusages area ON ST_DWithin(way.geometry, area.geometry, 1000) WHERE area.type IN ('industrial') AND way.osm_id=7981313 GROUP BY way.id;

SELECT AVG ( area . " PM10 Gesamtemissionen2008/2009 in t" ) AS val FROM osm_roads way LEFT JOIN pm_berlin area ON ST_DWithin ( ST_SetSRID ( way . geometry ,3857) ,ST_ENVELOPE ( ST_UNION ( ST_Transform (ST_SetSRID ( ST_Point ( ST_X ( area . geom )+1000 , ST_Y ( area . geom ) +1000) ,3068),3857) , ST_Transform ( area . geom ,3857) )) ,0) WHERE way . osm_id = " .. way : id () .. " GROUP BY way . id

SELECT 'DROP TABLE "' || TABLE_NAME || '";' FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE 'osm_%';

select id,osm_id,name,type,area,z_order,geometry from osm_landusages;
select id,osm_id,name,type,area,z_order from osm_landusages limit 20;

select id,osm_id,type,name,tunnel,bridge,oneway,ref,z_order,access,service,class,geometry from osm_roads limit 20;
select id,osm_id,type,name,tunnel,bridge,oneway,ref,z_order,access,service,class from osm_roads limit 20;

select id,osm_id,type,name,tunnel,bridge,oneway,ref,z_order,access,service,class from osm_roads where osm_id=7981313 limit 20;


https://github.com/ibikecph/osrm-backend/blob/green/profiles/green.lua#L401