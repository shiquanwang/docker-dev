# Personal docker based development environment
#
# Miniconda3: 3.18.3


FROM ubuntu:14.04.3
MAINTAINER Shiquan Wang <shiquanwang@gmail.com>

LABEL version="0.0.1" description="This is a personal docker based development environment."

# Proxy setting, need to clear details when do `git push`
# ENV http_proxy="http://172.17.0.1:3188/" \
#     https_proxy="http://172.17.0.1:3188/" \
#     ftp_proxy="http://172.17.0.1:3188/"
# RUN /bin/bash -c "echo 'Acquire::http::proxy \"http://172.17.0.1:3188/\";' >> /etc/apt/apt.conf"
# RUN /bin/bash -c "echo 'Acquire::https::proxy \"http://172.17.0.1:3188/\";' >> /etc/apt/apt.conf"
# RUN /bin/bash -c "echo 'Acquire::ftp::proxy \"http://172.17.0.1:3188/\";' >> /etc/apt/apt.conf"

# Initial apt-get update, upgrade and install
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential && \
    apt-get -y install software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install JAVA8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-add-repository -y ppa:webupd8team/java && \
    apt-get update &&\
    apt-get -y install oracle-java8-installer && \
    apt-get -y install oracle-java8-set-default && \
    rm -rf /var/cache/oracle-jdk8-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Conda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.18.3-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.18.3-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-3.18.3-Linux-x86_64.sh && \
    conda update --all -q -y

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]
