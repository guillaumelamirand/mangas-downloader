# Pull base image.
FROM ubuntu:20.04

ARG ARG_WORK_DIR=/mangas-downloader

# Environment variables
ENV WORK_DIR=$ARG_WORK_DIR
ENV CONFIG_FILE=$WORK_DIR/config.yml
ENV CRON_PERIOD='0 \*\/6 \* \* \*'

# Settings workspace
WORKDIR $WORK_DIR

# Create the pseudo log file to point to stdout
RUN ln -sf /proc/1/fd/1 /var/log/mangas-downloader.log

# Add crontab file in the working directory
ADD \ 
  cron/crontab.template crontab.template
ADD \
  cron/run.sh run.sh

# Add entrypoint
ADD \
  docker/entrypoint.sh entrypoint.sh 

# Allow execution on script
RUN \
  chmod +x *.sh

# Add python files
ADD \ 
  sources .

# Install package
# Must used calibre package to be able to run external module
ENV DEBIAN_FRONTEND noninteractive
RUN \
  apt-get update        && \
  apt-get upgrade -y    && \
  apt-get install -y       \
            calibre        \
            python3-pip    \
            cron
      
# Install python dependencies
RUN \
  pip3 install -r requirements.txt --no-cache-dir

# Clean apt
RUN \    
  rm -rf /var/lib/apt/lists/*
  
# Create manga user
RUN \
  useradd -m -G crontab mangas
RUN \
  chown -R mangas.mangas $WORK_DIR && \
  chown mangas.mangas /var/log/mangas-downloader.log

# Run the command on container startup
ENTRYPOINT \
  $WORK_DIR/entrypoint.sh
