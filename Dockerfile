# FROM nvidia/cuda
FROM ubuntu:latest
USER root
WORKDIR /home/uchiumi

# noniteractive
ENV DEBIAN_FRONTEND=noninteractive
# Time zone
ENV TZ=Asia/Tokyo 

# 確認した最新のアップデートを適用
RUN apt-get update
# dist-upgradeでディストリビューションを最新のものに適用
RUN apt-get -y upgrade
# 依存関係解決後に使わなくなったパッケージを削除
RUN apt-get -y dist-upgrade
# 他のパッケージの依存関係を満たすため自動的にインストールされ、不要になったパッケージを削除
RUN apt-get -y autoremove
# aptキャッシュを削除
RUN apt-get -y autoclean

# aptパッケージのインストール
RUN apt-get install -y \
    git \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    vim

RUN apt-get install -y python3 python3-pip

# pipインストール(最新版)
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN rm get-pip.py

# pip install
COPY requirements.txt ${PWD}
RUN pip install -r requirements.txt
