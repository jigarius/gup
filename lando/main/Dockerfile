FROM ubuntu:latest

RUN apt update -qq && apt install -qqy wget unzip

WORKDIR /app

# Install BATS
RUN wget -O /tmp/bats.zip https://github.com/bats-core/bats-core/archive/v1.2.1.zip
RUN unzip -o -d /tmp/ /tmp/bats.zip
RUN rm /tmp/bats.zip
RUN chmod 775 /opt
RUN mv /tmp/bats-core-* /opt/
RUN /opt/bats/install.sh /usr/local

CMD ["tail", "-f", "/dev/null"]
