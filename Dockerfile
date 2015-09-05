FROM jpizarrom/osrm-docker:v4.7.0

MAINTAINER Juan Pizarro "jpizarrom@gmail.com"


RUN apt-get install -yqq unzip && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && unzip awscli-bundle.zip && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

ADD solo-osrm-data-chile.json /chef/

ADD myapp /chef/cookbooks/myapp

ENV STORAGE_FLAVOR local

ADD run.sh /opt/

CMD ["/opt/run.sh"]
