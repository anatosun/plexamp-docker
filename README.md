# Plexamp Docker

This repository allows building a docker image of [Plexamp](https://plexamp.com/). Since Plexamp 4.7.0, Plexamp reads the claim and the player name from environment variables. This makes it much easier to spawn a Docker image.

## Compose file

Here is a compose file to get you started. Be sure to get a [fresh plex-claim](https://www.plex.tv/claim). Beware that this token is only valid for 4 minutes. If the initial pull/creation of the container takes more than that, the container will fail to start. In that case, get a new claim and recreate the container.

```yaml
version: "3"
services:
  plexamp:
    container_name: plexamp
    privileged: true
    image: ghcr.io/anatosun/plexamp:arm64v8
    devices:
      - "/dev/snd:/dev/snd"
    volumes:
      - ./config:/root/.local/share/Plexamp/Settings # replace that with the appropriate host binding
    environment:
      - PLEXAMP_CLAIM_TOKEN=claim-XXXXXXXXXX # get your claim at https://www.plex.tv/claim/
      - PLEXAMP_PLAYER_NAME=docker # replace this with your player name
    ports:
      - 32500:32500
      - 20000:20000
    restart: unless-stopped
```
