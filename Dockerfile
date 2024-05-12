FROM ubuntu:22.04 as builder

WORKDIR /root/

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

RUN apt install -y build-essential git autotools-dev automake

RUN git clone https://github.com/tinyproxy/tinyproxy

WORKDIR /root/tinyproxy

RUN ./autogen.sh
RUN ./configure
RUN make -j
RUN make install

CMD tinyproxy -d -c /tinyproxy.conf
