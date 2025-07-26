# =================================================================
# Stage 1: Builder - 使用 Debian Buster 并手动修复软件源
# =================================================================
FROM python:3.8-slim-buster as builder

# 设置环境变量
ENV LC_ALL=en_US.utf8 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on

# 修复 apt 源问题
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list && \
    apt-get update --allow-insecure-repositories && \
    apt-get install -y --no-install-recommends --allow-unauthenticated gcc libffi-dev && \
    rm -rf /var/lib/apt/lists/*

# 复制依赖文件到镜像中
COPY requirements.txt /tmp/requirements.txt

# 修复 pip 下载问题：使用国内镜像源并增加超时时间
RUN pip install --default-timeout=100 -r /tmp/requirements.txt

# =================================================================
# Stage 2: Final - 最终的轻量级运行镜像
# =================================================================
FROM python:3.8-slim-buster

ENV LC_ALL=en_US.utf8
WORKDIR /workspace

# 从 builder 阶段拷贝已安装的 Python 库和可执行文件
COPY --from=builder /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# 在一个 RUN 指令中完成所有 Jupyter 配置
RUN jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user && \
    jupyter notebook --generate-config --allow-root && \
    echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
    jt -t chesterish -f consolamono -fs 140 -altp -tfs 13 -nfs 115 -ofs 14 -cellw 80% -T

EXPOSE 8888

CMD [ "jupyter-notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--notebook-dir=/workspace" ]