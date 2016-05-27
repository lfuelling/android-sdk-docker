FROM ubuntu:14.04

MAINTAINER Lukas Fülling "lerk@lerk.io"

#First things first
RUN apt-get update && apt-get -y upgrade

# Install java7
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git unzip wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
ADD updateSDK.sh /opt/android-sdk-linux/updateSDK.sh
RUN chmod +x /opt/android-sdk-linux/updateSDK.sh
RUN /opt/android-sdk-linux/updateSDK.sh

# Install Gradle
ENV TERM dumb
ENV JAVA_OPTS -Xms256m -Xmx512m

# Pre-install gradle for faster builds. You can use the local gradle installation or the wrapper
# Based on niaquinto/gradle (https://github.com/niaquinto/docker-gradle)
ENV GRADLE_VERSION 2.10
ENV GRADLE_HASH 5b8ad24373252dabce9dead708e409f8
WORKDIR /usr/bin
RUN wget "https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
    echo "${GRADLE_HASH} gradle-${GRADLE_VERSION}-bin.zip" > gradle-${GRADLE_VERSION}-bin.zip.md5 && \
    md5sum -c gradle-${GRADLE_VERSION}-bin.zip.md5 && \
    unzip "gradle-${GRADLE_VERSION}-bin.zip" && \
    ln -s "gradle-${GRADLE_VERSION}" gradle && \
    rm "gradle-${GRADLE_VERSION}-bin.zip"

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Cleaning
RUN apt-get clean

# Go to workspace
RUN mkdir -p /opt/ws
WORKDIR /opt/ws
