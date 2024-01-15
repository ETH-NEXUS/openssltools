FROM ubuntu

RUN apt update && apt install -y openssl vim

RUN mkdir -p /tool/conf
RUN mkdir /CA

COPY conf /tool/conf/
COPY otca otcli /tool/

ENV PATH="${PATH}:/tool"

WORKDIR /tool