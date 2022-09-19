# Docker file for deoldify ChRIS plugin app
#
# Build with
#
#   docker build -t <name> .
#
# For example if building a local version, you could do:
#
#   docker build -t local/pl-deoldify .
#
# In the case of a proxy (located at 192.168.13.14:3128), do:
#
#    docker build --build-arg http_proxy=http://192.168.13.14:3128 --build-arg UID=$UID -t local/pl-deoldify .
#
# To run an interactive shell inside this container, do:
#
#   docker run -ti --entrypoint /bin/bash local/pl-deoldify
#
# To pass an env var HOST_IP to container, do:
#
#   docker run -ti -e HOST_IP=$(ip route | grep -v docker | awk '{if(NF==11) print $9}') --entrypoint /bin/bash local/pl-deoldify
#

FROM python:3.9.1-slim-buster
LABEL maintainer="Ranjini M N <rmandyam@redhat.com>"

WORKDIR /usr/local/src

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
RUN pip install .

RUN apt-get -y update
RUN apt-get -y install DeOldify 


CMD ["deoldify", "--help"]
