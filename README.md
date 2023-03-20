# drone-deta


[![BuildStatus](https://cloud.drone.io/api/badges/lizheming/drone-deta/status.svg)](https://cloud.drone.io/lizheming/drone-deta)
[![Docker Pulls](https://img.shields.io/docker/pulls/lizheming/drone-deta.svg)]()

<img src="deta.svg" alt="logo" width="240"/>

Deploying to [Deta](https://deta.space) with Drone CI
## Environment

- `SPACE_ACCESS_TOKEN`: Deta access token. [How to get Deta access token?](https://deta.space/docs/en/basics/cli#authentication)
- `SPACE_ID`: project id of an existing project
- `SPACE_TAG`: tag to identify this push
- `SPACE_DIR`: src of project to push (default "./")
- `SPACE_LISTED`: listed on discovery
- `SPACE_NOTES`: release notes
- `SPACE_RID`: revision id for release
- `SPACE_VERSIION`: version for the release

## Usage

```
docker run --rm \
  -e SPACE_ACCESS_TOKEN=access_token \
  -e SPACE_ID=id \
  lizheming/drone-deta
```
## Drone configuration examples

```yml
steps:
- name: deta
  image: lizheming/drone-deta
  settings:
    access_token:
      from_secret: space_access_token
    id: test-id
```