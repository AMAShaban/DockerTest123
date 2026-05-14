FROM ubuntu:22.04

# Install Java, X11 virtual display, and OpenGL drivers
USER root
RUN apt-get update && apt-get install -y \
    python3-pip \
    openjdk-21-jre-headless \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Create the Binder user (required)
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "Default user" --uid ${NB_UID} ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}
