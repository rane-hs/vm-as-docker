FROM python:3.7.7-buster
MAINTAINER rane

RUN curl -sL https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo "deb https://packages.nginx.org/unit/debian/ buster unit" >> /etc/apt/sources.list.d/unit.list
RUN echo "deb-src https://packages.nginx.org/unit/debian/ buster unit" >> /etc/apt/sources.list.d/unit.list
RUN apt-get --quiet update && apt-get --quiet install --no-install-recommends -y \
    default-mysql-client\
    bash-completion\
    sqlite3\
    locales\
    unit-python3.7\
    unit\
    default-mysql-client\
    sqlite3\
    locales\
    docker-compose\
    default-mysql-client\
    nginx\
    clang\
    curl\
    git\
    llvm\
    make\
    default-mysql-client\
    ssh\
    xz-utils\
    apt-utils\
    wget\
    cmake\
    nkf\
    nginx\
    task-japanese\
    openssh-server\
    apt-transport-https\
    vim\
    tig\
    docker.io\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN localedef -f UTF-8 -i ja_JP ja_JP
RUN apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# lang
RUN echo "ja_JP UTF-8" > /etc/locale.gen
RUN locale-gen
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
COPY entrypoint.sh /entrypoint.sh
RUN localedef -i /usr/share/i18n/locales/ja_JP -f UTF-8 /usr/lib/locale/ja_JP.UTF-8

ENV DOCKER_USER rane

RUN groupadd -r ${DOCKER_USER} && useradd -r -b / -g ${DOCKER_USER} -s /bin/bash ${DOCKER_USER}
RUN gpasswd -a ${DOCKER_USER} docker

WORKDIR /${DOCKER_USER}
WORKDIR /${DOCKER_USER}/venvs
WORKDIR /${DOCKER_USER}/home
RUN chown ${DOCKER_USER}:${DOCKER_USER} /${DOCKER_USER}
RUN chown ${DOCKER_USER}:${DOCKER_USER} /${DOCKER_USER}/venvs
RUN chown ${DOCKER_USER}:${DOCKER_USER} /${DOCKER_USER}/home
COPY --chown=${DOCKER_USER}:${DOCKER_USER} ./bin /${DOCKER_USER}/bin
COPY --chown=${DOCKER_USER}:${DOCKER_USER} ./gitconfig /${DOCKER_USER}/.gitconfig
COPY --chown=${DOCKER_USER}:${DOCKER_USER} ./ssh /${DOCKER_USER}/.ssh
COPY --chown=${DOCKER_USER}:${DOCKER_USER} ./.bashrc /${DOCKER_USER}/.bashrc
COPY --chown=${DOCKER_USER}:${DOCKER_USER} ./.xonshrc /${DOCKER_USER}/.xonshrc

WORKDIR /var/run/
RUN touch /var/run/docker.sock
RUN chown ${DOCKER_USER}:${DOCKER_USER} /var/run/docker.sock

# ここからゆーざーれいやー
USER ${DOCKER_USER}
RUN python3.7 -m venv /${DOCKER_USER}/venvs/api
RUN python3.7 -m venv /${DOCKER_USER}/venvs/common
RUN /${DOCKER_USER}/venvs/api/bin/pip install --quiet --upgrade pip setuptools wheel pycparser
RUN /${DOCKER_USER}/venvs/common/bin/pip install --quiet --upgrade pip setuptools wheel pycparser xonsh xonsh-autoxsh xonsh-vox-tabcomplete prompt-toolkit

RUN ln -s /${DOCKER_USER}/venvs/common/bin/xonsh /${DOCKER_USER}/bin/xonsh

# docker からはroot ユーザーからはssh 
USER root
