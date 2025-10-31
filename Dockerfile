FROM ubuntu:24.04

RUN apt update && apt install -y openssh-server python3 sudo \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && mkdir -p /var/run/sshd /tmp/.ansible/tmp \
    && chmod -R 777 /tmp/.ansible /tmp

RUN useradd -ms /bin/bash ansible && echo 'ansible:ansible' | chpasswd && adduser ansible sudo

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
