###########################################################
# Docker Development Environment Setup
#
# Copyright (c) Marcos Gomes-Borges
###########################################################

# Docker Base Image
###########################################################
ARG UBUNTU_VERSION=18.04
ARG ARCH=
ARG CUDA=10.0
FROM nvidia/cuda${ARCH:+-$ARCH}:${CUDA}-devel-ubuntu${UBUNTU_VERSION} as base
LABEL maintainer="Marcos Gomes-Borges"
LABEL version="1.0"
LABEL date="2019-07-12"

# ADD Installation Scripts
###########################################################
ADD ./scripts/install-nodejs.sh /tmp/
ADD ./scripts/install-pylibs.sh /tmp/
ADD ./scripts/install-jupyterlab.sh /tmp/
ADD ./scripts/install-ffmpeg.sh /tmp/
ADD ./scripts/install-protobuf.sh /tmp/
ADD ./scripts/install-opencv.sh /tmp/
ADD ./scripts/inputrc.ini /tmp/
ADD ./scripts/print.sh /tmp/

# Proxy
###########################################################
ENV http_proxy=""
ENV https_proxy=""
ENV ftp_proxy=""
ENV RSYNC_PROXY=""

# Improve Terminal (make sure things are pretty)
###########################################################
ENV SHELL=/bin/bash
ENV LANG=C.UTF-8
ENV TERM=xterm-256color

# Create a new Docker Image
###########################################################
WORKDIR /tmp

RUN apt-get update && \
    # Install dependencies
    # ---------------------------------------------------------
    apt-get --yes --quiet dist-upgrade && \
    apt-get install --yes --quiet --no-install-recommends \
       apt-utils \
       build-essential \
       pkg-config \
       rsync \
       software-properties-common \
       unzip \
       zip \
       wget \
       git \
       python3 \
       python3-pip \
       graphviz \
       pciutils \
    && \
    # Update Python Pip
    # ---------------------------------------------------------
    pip3 --no-cache-dir install --upgrade \
       pip \
       setuptools \
    && \
    # Improve Terminal
    # ---------------------------------------------------------
    cp /etc/skel/.bashrc ~/ && \
    sed -ri 's/^#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc && \
    cp inputrc.ini ~/.inputrc && \
    # Install tools
    # ---------------------------------------------------------
    /tmp/install-nodejs.sh && \
    /tmp/install-pylibs.sh && \
    /tmp/install-jupyterlab.sh && \
    /tmp/install-protobuf.sh && \
    /tmp/install-ffmpeg.sh && \
    /tmp/install-opencv.sh && \
    # Cleanup
    # ---------------------------------------------------------
    rm -rf ~/.cache/* && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

EXPOSE 8888/tcp

# Configure container startup
CMD ["jupyter", "lab", "--allow-root", "--no-browser", "--ip='0.0.0.0'", "--port=8888"]

# Build the image
# docker build --rm --tag img_name/tf1.12-cv4:19.05-py3 .