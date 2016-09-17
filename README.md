# android-sdk-docker

This docker image can be used to build Android Gradle projects with Java 7. The image is available on [DockerHub](https://hub.docker.com/r/lerk/android/)

Contains:

* Android SDK: full

## Build image

```bash
docker build -t lerk/android .
```

## Push build version to repository

```bash
docker push lerk/android
```

## Usage

### GitLab CI

This is what my .gitlab-ci.yml looks like:

```yaml
image: lerk/android

stages:
  - build

build:
  stage: build
  script:
    - ./gradlew build
  only:
    - master

```

### Without GitLab

```bash
docker pull lerk/android
```

Change directory to your project directory, then run:

```bash
docker run --tty --interactive --volume=$(pwd):/opt/workspace --workdir=/opt/workspace --rm lerk/android  /bin/sh -c "./gradlew build"
```

