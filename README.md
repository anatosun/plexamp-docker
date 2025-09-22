<p align="center"><img src="https://raw.githubusercontent.com/anatosun/plexamp-docker/main/assets/icon.svg"/></p>

This repository provides a Dockerfile and pre-built images of [Plexamp headless](https://plexamp.com/).

The architectures supported by this image are the following.

| Architecture | Available | Tag                     |
| :----------: | :-------: | ----------------------- |
|  Multi-arch  |    ✅     | latest, \<version tag\> |
|    x86-64    |    ✅     | amd64-\<version tag\>   |
|    arm64     |    ✅     | arm64v8-\<version tag\> |
|    arm32     |    ✅     | arm32v7-\<version tag\> |

The `latest` and version tags are multi-architecture manifests that automatically select the appropriate image for your platform.

## Compose file

Here is a compose file to get you started. Be sure to get a [fresh plex-claim](https://www.plex.tv/claim).

```yaml
services:
  plexamp:
    container_name: plexamp
    privileged: true
    image: ghcr.io/anatosun/plexamp:latest
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

- Beware that the claim token is only valid for four minutes. If the initial pull/creation of the container takes more than four minutes, the container will fail to start. In that case, get a new claim, edit the compose file, and recreate the container.
- If you encounter connection issues with your installation, you may try to change the `network_mode` to `host` by adding `network_mode: host` to the above `yaml` file and remove the port bindings.

## Trademark notice

Plexamp is a trademark of Plex. This project is an unofficial Docker image and is not affiliated with, endorsed by, or sponsored by Plex.
