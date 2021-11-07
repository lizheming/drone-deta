# drone-deta


[![BuildStatus](https://cloud.drone.io/api/badges/lizheming/drone-deta/status.svg)](https://cloud.drone.io/lizheming/drone-deta)
[![Docker Pulls](https://img.shields.io/docker/pulls/lizheming/drone-deta.svg)]()

<img src="deta.svg" alt="logo" width="240"/>

Deploying to [Deta](https://deta.sh) with Drone CI
## Environment

- `DETA_ACCESS_TOKEN`: Deta access token. [How to get Deta access token?](https://docs.deta.sh/docs/cli/auth#deta-access-tokens)
- `DETA_NAME`: Deta micro name
- `DETA_PROJECT`: Deta project name, default is "default".
- `DETA_PROJECT_DIR`: Directory of the project, default is ".".

## Usage

```
docker run --rm \
  -e DETA_ACCESS_TOKEN=access_token \
  -e DETA_NAME=name \
  lizheming/drone-deta
```
## Drone configuration examples

```yml
steps:
- name: deta
  image: lizheming/drone-deta
  settings:
    access_token:
      from_secret: deta_access_token
    name: test-name
    project: default
```