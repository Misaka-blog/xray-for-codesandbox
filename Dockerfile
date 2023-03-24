FROM nginx
MAINTAINER MisakaNo

RUN apt-get update -y && apt-get install -y wget unzip nginx supervisor net-tools

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/xray /usr/local/xray
COPY config.json /etc/xray/
COPY entrypoint.sh /usr/local/xray/

# 感谢 fscarmen 大佬提供 Dockerfile 层优化方案
RUN wget -q -O /tmp/xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -d /usr/local/xray /tmp/xray-linux-64.zip && \
    chmod a+x /usr/local/xray/entrypoint.sh