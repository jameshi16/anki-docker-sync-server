FROM python:3-slim

RUN apt-get update && apt-get install -y curl wget

RUN mkdir -p /opt/anki && pip install anki

WORKDIR /opt/sslproxy
RUN curl -s https://api.github.com/repos/suyashkumar/ssl-proxy/releases/latest\
  | grep "ssl-proxy-linux-amd64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | tail -n 1 \
  | wget -qi -
RUN tar xvf ssl-proxy-linux-amd64.tar.gz

COPY entrypoint.sh /opt/

WORKDIR /opt/
ENV SYNC_BASE=/opt/anki
EXPOSE 8080/tcp 8888/tcp
ENTRYPOINT ["./entrypoint.sh"]
