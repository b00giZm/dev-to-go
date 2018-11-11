FROM ubuntu:18.04

# Install base tooling
RUN apt-get update \
    && apt-get upgrade -yq \
    && apt-get install -yq \
        apt-transport-https \
        apt-utils \
        autoconf \
        automake \
        autotools-dev \
        ca-certificates \
        cmake \
        curl \
        gettext \
        git \
        g++ \
        libncurses-dev \
        libevent-dev \
        libtool \
        libtool-bin \
        ninja-build \
        pkg-config \
        python-dev \ 
        python-pip \ 
        python3-dev \ 
        python3-pip \
        software-properties-common \
        unzip 

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" \
    && apt-get update \
    && apt-get install -yq docker-ce

# Install tmux
ENV TMUX_TAG 2.8
RUN git clone https://github.com/tmux/tmux.git /tmp/src/tmux \
    && cd /tmp/src/tmux \
    && git fetch \
    && git fetch --tags \
    && git checkout ${TMUX_TAG} \
    && sh autogen.sh \
	&& ./configure \
    && make \
    && make install \
    && make clean

# Install Node.js
ENV NODE_VERSION 11
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y \
        nodejs

# Install nvim
ENV NVIM_TAG v0.3.1
RUN git clone https://github.com/neovim/neovim.git /tmp/src/nvim \
    && cd /tmp/src/nvim \
    && git fetch \
    && git fetch --tags \
    && git checkout ${NVIM_TAG} \
    && make \
    && make install \
    && make clean \
    && pip3 install --upgrade \
        flake8 \
        jedi \
        neovim \
        pylint \
    && npm install -g \
        eslint \
        prettier

# Install AWS tools
RUN pip3 install --upgrade \
        awscli
