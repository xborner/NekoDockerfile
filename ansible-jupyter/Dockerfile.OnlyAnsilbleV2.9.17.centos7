FROM centos:7

# Set http proxy
ENV http_proxy http://10.253.195.71:1082
ENV https_proxy http://10.253.195.71:1082
ENV ANSIBLE_VERSION 2.9.17
ENV LC_ALL en_US.utf8

RUN yum check-update; \
    yum install -y gcc libffi-devel python3 epel-release; \
    yum install -y python3-pip; \
    yum clean all

RUN pip3 install --upgrade pip; \
    pip3 install "ansible==${ANSIBLE_VERSION}"; \
    pip3 install ansible[azure]
