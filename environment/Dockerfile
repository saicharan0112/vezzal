FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y upgrade
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install wget git -y

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.12.0-Linux-x86_64.sh \
    && bash Miniconda3-py37_4.12.0-Linux-x86_64.sh -b -p /usr/bin/miniconda3/ \
    && rm -f Miniconda3-py37_4.12.0-Linux-x86_64.sh

ENV PATH=/usr/bin/miniconda3/bin/:${PATH}
RUN conda update -y conda
RUN conda install -c litex-hub open_pdks.sky130a -y
ENV PDK_ROOT=/usr/bin/miniconda3/share/pdk
WORKDIR /vezzal