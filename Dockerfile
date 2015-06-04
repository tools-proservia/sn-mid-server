FROM ubuntu:14.04

MAINTAINER Tools Management <tools_management@proservia.fr>

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -q update && apt-get install -qy unzip \
    supervisor \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ADD asset/* /opt/

# Install MID Server
RUN wget --no-check-certificate \
      https://install.service-now.com/glide/distribution/builds/package/mid/2015/03/09/mid.2015-03-09-2230.linux.x86-64.zip \
      -O /tmp/mid.zip && \
    unzip -d /opt /tmp/mid.zip && \
    mv /opt/agent/config.xml /opt/ && \
    chmod 755 /opt/init && \
    rm -f /tmp/mid.zip

EXPOSE 80

ENTRYPOINT ["/opt/init"]

CMD ["mid:start"]
