FROM ubuntu:22.04
MAINTAINER Logan A Walker <loganaw@umich.edu>

# Prevent installers from prompting
ENV DEBIAN_FRONTEND noninteractive
ENV container docker

##############################
# Install System-wide Packages
##############################

# Install some tools
RUN apt-get update
RUN apt-get install --no-install-recommends -y wget ca-certificates
RUN apt install -y htop screenfetch nload

# Install tigervnc
RUN wget -v -O tigervnc-1.10.0.x86_64.tar.gz https://sourceforge.net/projects/tigervnc/files/stable/1.10.0/tigervnc-1.10.0.x86_64.tar.gz
RUN tar xz -f tigervnc-1.10.0.x86_64.tar.gz --strip 1 -C /
#RUN rm -rf tigervnc-1.10.0.x86_64.tar.gz 

# Install desktop environment
RUN apt install -y lxde
RUN apt install -y x11-utils
RUN apt install -y build-essential

# Fun apps
RUN apt install -y libreoffice
RUN apt install -y gimp
#RUN apt install -y code

# System utilities
RUN apt install -y fuse snapd snap-confine squashfuse sudo init screen parallel

# Clear buffer
RUN apt clean

# Download for later use
RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh
RUN chmod +x Anaconda*.sh
RUN wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip

# Install Chrome (broken :( )
#ADD google-chrome-stable_current_amd64.deb /
#RUN apt install -y libu2f-udev # chrome dependency
#RUN sudo dpkg -i /google-chrome-stable_current_amd64.deb
#RUN rm -f /google-chrome-stable_current_amd64.deb

# Install Firefox
RUN apt install -y software-properties-common
ADD install_firefox.sh /
RUN sh /install_firefox.sh
RUN rm -f /install_firefox.sh

# Install SSH
RUN apt install -y openssh-server openssh-client
RUN ssh-keygen -A
RUN echo "HostKey /etc/ssh/ssh_host_rsa_key" >> /etc/ssh/sshd_config
RUN mkdir /run/sshd

#RUN apt install -y xubuntu-desktop

##############################
# Set environment variables
##############################

ENV HOME=/home/ubuntu
ENV DISPLAY=:0
ENV SHELL=/bin/bash
ENV START_DIR=/home/ubuntu

ENV VNC_RESOLUTION=1920x1080
ENV VNC_COL_DEPTH=24
ENV VNC_PW=password
ENV VNC_PORT=5900

EXPOSE ${VNC_PORT}

##############################
# Perform userspace setup
##############################
    
# Create user
RUN useradd -ms /bin/bash ubuntu -d ${HOME}
RUN echo "ubuntu:ubuntu" | chpasswd

# Copy startup script
ADD startup.sh ${HOME}
ADD startup2.sh ${HOME}
RUN chmod +x ${HOME}/startup.sh
RUN chmod +x ${HOME}/startup2.sh
RUN usermod -aG sudo ubuntu

# Set user environment
#USER ubuntu
WORKDIR /home/ubuntu

# Install conda
ADD install_conda.sh ${HOME}
RUN su ubuntu -c "/bin/bash install_conda.sh"
RUN rm ${HOME}/install_conda.sh

# Install Fiji
RUN su ubuntu -c "unzip /fiji-linux64.zip -d ${HOME}/"

##############################
# Launch
##############################

ENTRYPOINT ["/home/ubuntu/startup.sh"]


