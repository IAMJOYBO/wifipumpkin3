FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y install wget libglib2.0-0 python3-opencv vim \
        hostapd \
	    nano \
	    iw \
        wireless-tools \
        ifupdown \
        iptables \
        net-tools \
        rfkill \
        libpcap-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh && bash Miniconda3-latest-Linux-$(uname -m).sh -b -p /app/miniconda
RUN /app/miniconda/bin/conda init
ENV PATH=/app/miniconda/bin:$PATH
RUN echo yes | conda create --name wifi python=3.8 cryptography
SHELL ["conda", "run", "-n", "wifi", "/bin/bash", "-c"]
RUN conda config --set auto_activate_base false
# copy all files to app folder
COPY . /usr/src/app
WORKDIR /usr/src/app
COPY config/hostapd/hostapd.conf /etc/hostapd/hostapd.conf

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pyqt5==5.14
RUN python3 -m pip install . && pip cache purge

WORKDIR /root/.config/wifipumpkin3

ENTRYPOINT ["tail", "-f", "/dev/null"]
