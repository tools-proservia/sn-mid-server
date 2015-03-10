FROM ubuntu:14.04.2
MAINTAINER Tools Management <tools_management@proservia.fr>

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -q update && apt-get install -qy unzip \
    supervisor \
    wget

# Install MID Server
RUN wget --no-check-certificate https://install.service-now.com/glide/distribution/builds/package/mid/2015/03/09/mid.2015-03-09-2230.linux.x86-64.zip -O /tmp/mid.zip
RUN unzip -d /opt /tmp/mid.zip
RUN mv /opt/agent/config.xml /opt/

ADD asset/supervisord.conf /opt/supervisord.conf
ADD asset/init /opt/init
RUN chmod 755 /opt/init

# Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/*

EXPOSE 80

ENTRYPOINT ["/opt/init"]
CMD ["mid:start"]
