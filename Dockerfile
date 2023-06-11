FROM node:16-bullseye


RUN apt-get update && apt-get install -y -q --no-install-recommends \
        jq \
        wget \
        libasound2 
ENV WORKDIR /home/root/
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR
RUN wget -q "$(curl -s "https://plexamp.plex.tv/headless/version$1.json" | jq -r '.updateUrl')" -O plexamp.tar.bz2
RUN tar xfj plexamp.tar.bz2
ENV WORKDIR $WORKDIR/plexamp
WORKDIR $WORKDIR
ENTRYPOINT node $WORKDIR/js/index.js
