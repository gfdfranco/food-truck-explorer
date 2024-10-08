# Use an official Elixir runtime as a parent image.
FROM elixir:latest
LABEL maintainer="Gerardo Franco <gfd.francodelgado@gmail.com>"

ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get -y update

RUN apt-get install -y libsm6 libxext6
RUN apt-get install -y curl 
RUN apt-get install -y git
RUN apt-get install -y zip unzip
RUN apt-get install -y nano
RUN apt-get install -y vim
RUN apt-get install -y wget
RUN apt-get install -y inotify-tools
RUN apt-get install -y screen
RUN apt-get install -y sl
RUN apt-get install -y ffmpeg
RUN apt-get install -y postgresql-client

ARG USER=gfdfranco
ARG HOME=/home/$USER
ARG USER_ID=1000

ENV USER=$USER \
    HOME=$HOME

RUN groupadd $USER && \
    useradd -u $USER_ID -d $HOME -g $USER -ms /bin/bash $USER && \
    mkdir -p $HOME/workspace

# Copy files and set permissions
COPY ./entrypoint.sh $HOME/
COPY ./backend_project/ $HOME/workspace/backend_project 

RUN chown -R $USER:$USER $HOME && \
    chmod +x $HOME/entrypoint.sh && \
    chmod -R 755 $HOME/workspace

USER $USER


CMD ["/home/gfdfranco/entrypoint.sh"]