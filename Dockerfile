FROM node:21.7.2-bullseye-slim

RUN apt update && apt install -y -q \
        jq \
        wget \
        libasound2 \
        bzip2 \
        curl

ENV WORKDIR /root
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR
RUN wget -q "$(curl -s "https://plexamp.plex.tv/headless/version$1.json" | jq -r '.updateUrl')" -O plexamp.tar.bz2
RUN tar xfj plexamp.tar.bz2
ENV WORKDIR $WORKDIR/plexamp
WORKDIR $WORKDIR
ENTRYPOINT node $WORKDIR/js/index.js
