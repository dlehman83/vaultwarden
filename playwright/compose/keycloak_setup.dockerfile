FROM registry.access.redhat.com/ubi9 AS ubi-micro-build

RUN dnf install -y wget && wget -O /root/jq https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64 && chmod +x /root/jq

FROM quay.io/keycloak/keycloak:25.0.1
COPY --from=ubi-micro-build /root/jq /usr/bin/jq

COPY keycloak_setup.sh /keycloak_setup.sh

ENTRYPOINT [ "bash", "-c", "/keycloak_setup.sh"]
