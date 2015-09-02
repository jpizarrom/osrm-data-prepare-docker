FROM jpizarrom/osrm-docker:v4.7.0

MAINTAINER Juan Pizarro "jpizarrom@gmail.com"

ADD solo-osrm-data-chile.json /chef/

ADD myapp /chef/cookbooks/myapp

CMD [ "chef-solo", "-c", "/chef/solo.rb", "-j", "/chef/solo-osrm-data-chile.json" ]