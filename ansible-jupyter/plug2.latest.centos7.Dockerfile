FROM centos:7

# Set http proxy
ENV http_proxy http://192.168.1.165:1082
ENV https_proxy http://192.168.1.165:1082
ENV ANSIBLE_VERSION 2.9.17
ENV LC_ALL en_US.utf8

# Install python3
RUN yum check-update; \
    yum install -y gcc libffi-devel python3 epel-release; \
    yum install -y python3-pip; \
    yum clean all

# Install ansible && pywinrm
RUN pip3 install --upgrade pip; \
    pip3 install "ansible==${ANSIBLE_VERSION}"; \
    pip3 install ansible[azure]; \
    pip3 install pywinrm

# Install jupyter && plug
RUN pip3 install jupyter; \
    pip3 install jupyter_contrib_nbextensions; \
    pip3 install jupyter_nbextensions_configurator; \
    jupyter contrib nbextension install --user; \
    jupyter nbextensions_configurator enable --user

# Install Kerberos client. Not required!?
# RUN yun install -y krb5-libs krb5-workstation pam_krb5
#     pip3 install Kerberos

# Cancel jupyter password
RUN jupyter notebook --generate-config && \
    echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py

# Install jupyter theme
RUN pip3 install jupyterthemes; \
    jt -t chesterish -f consolamono -fs 140 -altp -tfs 13 -nfs 115 -ofs 14 -cellw 80% -T

# Run service of Jupyter.
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "docker-entrypoint.sh" ]
EXPOSE 8888

CMD [ "jupyter", "--version" ]
