FROM ubuntu:22.04 as builder

WORKDIR /root/

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends build-essential git autotools-dev automake && apt-get clean all

COPY tinyproxy/ tinyproxy/

WORKDIR /root/tinyproxy

RUN ./autogen.sh
RUN ./configure
RUN make -j
RUN make install

CMD tinyproxy -d -c /tinyproxy.conf
