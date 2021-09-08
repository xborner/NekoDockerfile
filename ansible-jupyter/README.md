# Ansible-Jupyter Dockerfile

## 简介
|应用名称|备注|
|:----:|:----:|
|Ansible|后端服务，运行配置，实现自动化运维过程|
|Jupyter|前端实现计算机操作交互|
|Python3|装 Jupyter 必备条件|

Ansible 和 Jupyter 是绝妙的组合，Ansible 负责后端服务，批量控制机器，Jupyter 负责处理前端交互，在网页上处理相关命令，彼此配合实现强大功能。

~~基于 [ansible-jupyter.dockerfile](https://github.com/chusiang/ansible-jupyter.dockerfile) 做了一些修改。~~

原仓库基于 Python2，现更新为基于 Python3 内核版本。同时给 Jupyter 添加了主题、插件等，让页面更加美观易用，修复了无法输入中文问题。

## Dockerfile 说明
[plug2.latest.centos7.Dockerfile](plug2.latest.centos7.Dockerfile)
Ansible-Jupyter，添加了 chesterish 主题 consolamono 字体，以及 jupyter_contrib_nbextensions 插件功能，可根据需要增删部分内容。

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

  1. 给启动脚本赋予权限

      ```
      $ chmod 755 docker-entrypoint.sh
      ```
  1. 构建镜像

      ```
      $ docker build -t xborner/ansible-jupyter-plug2 . -f plug2.latest.centos7.Dockerfile
      ```

## 运行容器

  1. 获取镜像
      ```
        $ docker pull xborner/ansible-jupyter-plug2
      ```

2. 以守护进程模式启动容器
      ```
        $ docker run --name ansible-jupyter-plug2 -p 8888:8888 -d xborner/ansible-jupyter-plug2
      ```
3. 检查容器运行情况
      ```
        $ docker ps
      ```

## 使用
在浏览器中打开 http://127.0.0.1:8888 开始访问。
