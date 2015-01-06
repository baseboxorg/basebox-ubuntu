FROM ubuntu:latest

MAINTAINER BaseBoxOrg <open@basebox.org>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install git openssh-server pwgen locales

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh

ADD run.sh /run.sh

RUN chmod +x /*.sh

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8


ENV AUTHORIZED_KEYS **None**

EXPOSE 22

CMD ["/run.sh"]
