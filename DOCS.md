---
date: 2021-11-07T00:00:00+00:00
title: Deta
author: lizheming
tags: [ deploy, deta ]
repo: lizheming/drone-deta
logo: deta.svg
image: lizheming/drone-deta
---

The Deta plugin deploy your build to [deta.space](https://deta.space).

The below pipeline configuration demonstrates simple usage:

```yml
steps:
- name: deta
  image: lizheming/drone-deta
  settings:
    access_token:
      from_secret: space_access_token
    id: test-id
```

# Parameter Reference

access_token: Deta access token. [How to get Deta access token?](https://deta.space/docs/en/basics/cli#authentication)

id: project id of an existing project

tag: tag to identify this push

dir: src of project to push (default "./")

listed: listed on discovery

notes: release notes

rid: revision id for release

versioin: version for the release