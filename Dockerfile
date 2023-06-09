FROM debian:stable


RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        jq \
        git \
        libssl-dev \
        wget 
RUN useradd -ms /bin/bash plexamp
USER plexamp
WORKDIR /home/plexamp
ENV NVM_VERSION 0.39.3
ENV NVM_DIR /home/plexamp/.nvm 
RUN mkdir $NVM_DIR
ENV NODE_VERSION 16.18.1
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin/node
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN wget -q "$(curl -s "https://plexamp.plex.tv/headless/version$1.json" | jq -r '.updateUrl')" -O plexamp.tar.bz2
RUN tar xfj plexamp.tar.bz2
ENTRYPOINT $NODE_PATH plexamp/js/index.js
