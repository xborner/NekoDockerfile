FROM ubuntu:18.04

# Set http proxy
ENV http_proxy http://10.253.195.71:1082
ENV https_proxy http://10.253.195.71:1082
RUN echo 'export http_proxy="http://10.253.195.71:1082"' >> ~/.bashrc
RUN echo 'export http_proxy="https://10.253.195.71:1082"' >> ~/.bashrc
#RUN export http_proxy="http://10.253.195.71:1082"
#RUN export http_proxy="https://10.253.195.71:1082"

MAINTAINER Chu-Siang Lai <chusiang@drx.tw>


# Update the index of available packages.
RUN apt-get update

# Install the requires apt package and python.
RUN apt-get install -y --no-install-recommends \
      linux-headers-generic gcc build-essential python python-pip python-dev \
      libffi-dev \
      && \
      apt-get clean

# Setup the ansible.
RUN apt-get install -y --no-install-recommends software-properties-common

RUN add-apt-repository ppa:ansible/ansible -y && apt-get update

RUN apt-get install -y --no-install-recommends \
      ansible \
      && \
      apt-get clean

# for disable localhost warning message.
RUN /bin/echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Upgrade the pip to lastest.
RUN pip install -U pip

# Setup with Ansible.
ADD https://raw.githubusercontent.com/chusiang/ansible-jupyter.dockerfile/master/setup_jupyter.yml /home
RUN ansible-playbook -v /home/setup_jupyter.yml

# Copy a ipython notebook example to image.
ADD https://raw.githubusercontent.com/chusiang/ansible-jupyter.dockerfile/master/ipynb/ansible_on_jupyter.ipynb /home/
ADD https://raw.githubusercontent.com/chusiang/ansible-jupyter.dockerfile/master/ipynb/ansible_on_jupyter_ubuntu.ipynb /home/

# Install jupyter_contrib_nbextensions
RUN pip install jupyter_contrib_nbextensions && pip install jupyter_nbextensions_configurator
RUN jupyter contrib nbextension install --user && jupyter nbextensions_configurator enable --user

# Run service of Jupyter.
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]
EXPOSE 8888

CMD [ "jupyter", "--version" ]
