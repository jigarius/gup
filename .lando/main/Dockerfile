FROM ubuntu:latest

RUN apt update -qq
RUN apt install -qqy wget unzip shellcheck

WORKDIR /app

# Install BATS
RUN chmod 775 /opt
RUN wget -O /tmp/bats.zip https://github.com/bats-core/bats-core/archive/v1.2.1.zip
RUN unzip -q -o -d /opt/ /tmp/bats.zip
RUN rm /tmp/bats.zip
RUN /opt/bats-core-*/install.sh /usr/local

# Create sandbox.
RUN mkdir -p /var/www/alpha/bravo/charlie/charlie/echo
RUN mkdir -p /var/www/alpha/bravo/charlie/delta
RUN mkdir -p /var/www/alpha/bravo/sierra sierra/tango

CMD ["tail", "-f", "/dev/null"]
