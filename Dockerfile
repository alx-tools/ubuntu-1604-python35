FROM holbertonschool/base-ubuntu-1604
MAINTAINER Guillaume Salva <guillaume@holbertonschool.com>

RUN apt-get update

# MySQL
RUN echo "mysql-community-server mysql-community-server/data-dir select ''" | debconf-set-selections
RUN echo "mysql-community-server mysql-community-server/root-pass password root" | debconf-set-selections
RUN echo "mysql-community-server mysql-community-server/re-root-pass password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get install -y --force-yes mysql-server-5.7
RUN apt-get install -y --force-yes libmysqlclient-dev
RUN apt-get install -y libssl-dev

# Pip
RUN apt-get install -y python3.5-dev
RUN curl -O https://bootstrap.pypa.io/pip/3.5/get-pip.py
RUN python3 get-pip.py
RUN pip3 install pep8
RUN pip3 install pycodestyle

RUN pip3 install SQLAlchemy
RUN pip3 install sqlalchemy
RUN pip3 install sqlalchemy --upgrade
RUN pip3 install mysqlclient==1.3.10

ADD run.sh /etc/sandbox_run.sh
RUN chmod u+x /etc/sandbox_run.sh

# start run!
CMD ["./etc/sandbox_run.sh"]
