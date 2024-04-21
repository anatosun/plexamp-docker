# Plexamp Headless Docker

This repository allows building a docker image of [Plexamp headless](https://plexamp.com/) and also provides a pre-built image at `ghcr.io/anatosun/plexamp:arm64v8`.

The architectures supported by this image are the following.

| Architecture | Available | Tag                     |
| :----------: | :-------: | ----------------------- |
|    x86-64    |    ✅     | amd64-\<version tag\>   |
|    arm64     |    ✅     | arm64v8-\<version tag\> |
|    arm32     |    ✅     | arm32v7-\<version tag\> |

Omitting the \<version tag\> will pull the latest version.

## Compose file

Here is a compose file to get you started. Be sure to get a [fresh plex-claim](https://www.plex.tv/claim).

```yaml
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

## Remarks

- Beware that the claim token is only valid for 4 minutes. If the initial pull/creation of the container takes more than that, the container will fail to start. In that case, get a new claim, edit the compose file, and recreate the container.
