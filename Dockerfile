FROM    debian

COPY    . /root/wiki

ARG     DEBIAN_FRONTEND=noninteractive

RUN     \
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y dialog apt-utils && \
    apt-get upgrade -y && \
    apt-get clean

RUN     \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    npm config set registry https://registry.npm.taobao.org && \
    npm install -g tiddlywiki

EXPOSE 8090

ENTRYPOINT [ "tiddlywiki", "/root/wiki", "--listen" ]

CMD [ "host=0.0.0.0", "port=8090", "gzip=on" ]
