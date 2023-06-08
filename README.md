# Plexamp Docker

This repository allows building a docker image of [Plexamp](https://plexamp.com/). Since Plexamp 4.70, Plexamp reads the claim and the player name from environment variables. This makes it much easier to spawn a Docker image.

```yaml
version: '3'
services:
   plexamp:
     container_name: plexamp 
     privileged: true
     network_mode: "host" 
     image: ghcr.io/anatosun/plexamp:latest
     volumes: 
        - /data/docker/plexamp/:/home/plexamp:rw 
    environment:
        - PLEXAMP_PLAYER_NAME=claim-XXXXXXXXXX # get your claim at https://www.plex.tv/claim/
        - PLEXAMP_PLAYER_NAME=docker # replace this with your player name
    restart: unless-stopped
```
