FROM ubuntu:16.04
MAINTAINER Guillaume Salva <guillaume@holbertonschool.com>

RUN apt-get update
RUN apt-get -y upgrade

# curl/wget/git
RUN apt-get install -y sudo curl wget git
# vim/emacs
RUN apt-get install -y vim emacs

# MySQL
RUN echo "mysql-community-server mysql-community-server/data-dir select ''" | debconf-set-selections
RUN echo "mysql-community-server mysql-community-server/root-pass password root" | debconf-set-selections
RUN echo "mysql-community-server mysql-community-server/re-root-pass password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y --force-yes mysql-server-5.7
RUN apt-get install -y --force-yes libmysqlclient-dev

# Pip
RUN apt-get install -y python3-pip
RUN pip3 install pep8
RUN pip3 install pycodestyle

RUN pip3 install SQLAlchemy
RUN pip3 install sqlalchemy
RUN pip3 install sqlalchemy --upgrade
RUN pip3 install mysqlclient==1.3.10

# Set the locale
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# SSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
RUN sed -ri 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

ADD run.sh /tmp/run.sh
RUN chmod u+x /tmp/run.sh

# start run!
CMD ["./tmp/run.sh"]

