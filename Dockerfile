FROM centos:latest

RUN useradd -m -d /home/docker_root -s /bin/sh docker_root

# Standard SSH port
EXPOSE 22

# Install openssh-server
RUN yum -y install openssh-server openssh-clients

# Generate keys
RUN ssh-keygen -A

# User docker_root
USER docker_root
RUN mkdir /home/docker_root/.ssh
RUN ssh-keygen -N '' -f /home/docker_root/.ssh/id_rsa
RUN ssh-keygen -y -f /home/docker_root/.ssh/id_rsa > /home/docker_root/.ssh/id_rsa.pub

USER root
COPY add_key.sh /home/docker_root/
COPY connectivity_test.sh /home/docker_root/
WORKDIR /home/docker_root/
RUN chown docker_root:docker_root ./add_key.sh ./connectivity_test.sh
RUN chmod +x ./add_key.sh ./connectivity_test.sh

# Default command
USER root
CMD ["/usr/sbin/sshd", "-D"]
