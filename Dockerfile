FROM ubuntu:22.04

# 1. Install System Dependencies (Java, X11, and OpenGL)
RUN apt-get update && apt-get install -y \
    python3-pip \
    openjdk-21-jre-headless \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    xvfb \
    x11vnc \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

# 2. Install PortableMC and Jupyter
RUN pip3 install portablemc jupyterlab

# 3. Setup user to avoid root issues
RUN useradd -m jovyan
USER jovyan
WORKDIR /home/jovyan

# 4. Expose ports for Jupyter
EXPOSE 8888
