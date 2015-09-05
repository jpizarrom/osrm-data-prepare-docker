FROM jpizarrom/osrm-docker:v4.7.0

MAINTAINER Juan Pizarro "jpizarrom@gmail.com"

ADD solo-osrm-data-chile.json /chef/

ADD myapp /chef/cookbooks/myapp

ADD run.sh /opt/

CMD ["/opt/run.sh"]
