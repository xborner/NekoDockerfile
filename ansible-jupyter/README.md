# Ansible-Jupyter Dockerfile

## 简介
|应用名称|备注|
|:----:|:----:|
|Ansible|后端服务，运行配置，实现自动化运维过程|
|Jupyter|前端实现计算机操作交互|
|Python3|装 Jupyter 必备条件|

Ansible 和 Jupyter 是绝妙的组合，Ansible 负责后端服务，批量控制机器，Jupyter 负责处理前端交互，在网页上处理相关命令，彼此配合实现强大功能。

~~基于 [ansible-jupyter.dockerfile](https://github.com/chusiang/ansible-jupyter.dockerfile) 做了一些修改。~~

原仓库基于 Python2，现更新为基于 Python3 内核版本。同时给 Jupyter 添加了主题、插件等，让页面更加美观易用。

## Dockerfile 说明
[plug2.latest.centos7.Dockerfile](plug2.latest.centos7.Dockerfile)
Ansible-Jupyter，添加了 chesterish 主题 consolamono 字体，以及 jupyter_contrib_nbextensions 插件功能，可根据需要增删部分内容。

[plug2krb.latest.centos7.Dockerfile(调试中)](plug2krb.latest.centos7.Dockerfile)
在上面的基础上新增安装 Kerberos，可控制加了域的 Windows 机器。

[OnlyAnsibleV2.9.17.centos7.Dockerfile](./OnlyAnsibleV2.9.17.centos7.Dockerfile)
仅安装 AnsibleV2.9.17，基于 Python3。

~~[latest.ubuntu1804.Dockerfile](./latest.ubuntu1804.Dockerfile)
Ansible-jupyter 组合，基于 Python2~~

## 构建镜像

  1. 克隆仓库

      ```
      $ git clone https://github.com/xborner/NekoDockerfile.git
      ```

  1. 进入 Dockerfile 目录

      ```
      $ cd ./NekoDockerfile/ansible-jupyter/
      ```

  1. 构建镜像

      ```
      $ docker build -t xborner/ansible-jupyter . -f plug2.latest.centos7.Dockerfile
      ```

## 运行容器

## 使用
