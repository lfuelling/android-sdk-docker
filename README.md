# android-java7

This docker is used to build Android Gradle projects with Java 7.

Contains:

* Android SDK: r24.4.1
* Build tools
* Android API
* Support maven repository
* Google maven repository
* Arm emulator: v21
* Platform tools

I installed the SDK using this filter:
```
tools,
platform-tools,
build-tools-23.0.2,
build-tools-22.0.1,
android-23,
android-22,
android-21,
sys-img-armeabi-v7a-android-23,
addon-google_apis-google-23,
addon-google_apis-google-22,
extra-android-m2repository,
extra-android-support
```

If you need something else, change the `updateSDK.sh` script and rebuild the image.

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

Change directory to your project directory, then run:

```bash
docker run --tty --interactive --volume=$(pwd):/opt/workspace --workdir=/opt/workspace --rm lerk/android:java7  /bin/sh -c "./gradlew build"
```

