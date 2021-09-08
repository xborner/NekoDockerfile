# webui2-aria2

fork from [webui-aria2](https://github.com/ziahamza/webui-aria2)，更改内容：增加代理、给 /data 目录赋予权限。

aira2 是一款使用 C++ 编写的轻量级跨平台命令行下载工具，支持 HTTP/HTTPS, FTP, SFTP, BitTorrent 和 Metalink 等多种协议，可用它来优雅的下载学习资料（：

![](assets/markdown-img-paste-20210905185324359.png)

## 构建镜像
1. 克隆仓库

    ```
    $ git clone https://github.com/xborner/NekoDockerfile.git
    ```

1. 进入 Dockerfile 目录

    ```
    $ cd ./NekoDockerfile/webui2-aria2/
    ```

1. 构建镜像

    ```
    $ docker build -t xborner/webui2-aria2 .
    ```

## 运行容器

  1. 获取镜像
      ```
        $ docker pull xborner/webui2-aria2
      ```

2. 以守护进程模式启动容器
      ```
        $ docker run -v /Downloads:/data -p 6800:6800 -p 9100:8080 -d --name="webui2-aria2" xborner/webui2-aria2
      ```
3. 检查容器运行情况
      ```
        $ docker ps
      ```


## 使用
网页访问 http://localhost:9100 即可。
