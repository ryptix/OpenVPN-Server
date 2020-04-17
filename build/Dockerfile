FROM debian:buster-slim
ADD ./src /
RUN apt update && apt -y upgrade &&\
	apt install -y openvpn wget tar net-tools
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
