ARG base_image
FROM ${base_image}
RUN apt-get update && apt-get install -y sudo build-essential nano
RUN groups && echo "WO"
SHELL ["/bin/bash", "--login", "-i","-c"]
RUN adduser --disabled-password --gecos '' docker 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN adduser docker sudo
RUN sudo bash -c "wget -O - https://github.com/Kitware/CMake/releases/download/v3.23.2/cmake-3.23.2-linux-x86_64.tar.gz | tar -xz --strip-components 1 -C /usr/"
RUN sudo ln -s /usr/bin/make /usr/bin/gmake
RUN sudo ln -s /usr/bin/make /usr/bin/MAKE

USER docker
WORKDIR /home/docker/
COPY ./jupyter-src/override_addon /tmp/override_addon
RUN sudo pip install --pre jupyterlite /tmp/override_addon pkginfo
RUN echo 'export PYODIDE_ROOT=/home/docker/src/pyodide' >> .bashrc
VOLUME /home/docker/src

