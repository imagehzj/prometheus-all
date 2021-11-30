FROM ttbb/node-exporter:nake AS node

FROM ttbb/prometheus:nake

COPY --from=node /opt/sh/node_exporter /opt/sh/node_exporter

ARG TARGETARCH

COPY source /opt/sh/mate

RUN wget https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-$TARGETARCH.tar.gz  && \
mkdir -p /opt/sh/alertmanager && \
tar -xf alertmanager-0.23.0.linux-$TARGETARCH.tar.gz -C /opt/sh/alertmanager --strip-components 1 && \
rm -rf alertmanager-0.23.0.linux-$TARGETARCH.tar.gz && \
wget https://github.com/prometheus/pushgateway/releases/download/v1.4.2/pushgateway-1.4.2.linux-$TARGETARCH.tar.gz && \
mkdir -p /opt/sh/pushgateway && \
tar -xf pushgateway-1.4.2.linux-$TARGETARCH.tar.gz -C /opt/sh/pushgateway --strip-components 1 && \
rm -rf pushgateway-1.4.2.linux-$TARGETARCH.tar.gz

WORKDIR /opt/sh

CMD ["/usr/local/bin/dumb-init", "bash", "-vx","/opt/sh/mate/scripts/start.sh"]