FROM bstick12/ubuntu-dind
RUN apt-get update
RUN apt-get install wget jq -y
RUN wget -c https://github.com/buildpacks/pack/releases/download/v0.6.0/pack-v0.6.0-linux.tgz -O - | tar -zx -C /usr/local/bin
#COPY --from=builder /assets/ /opt/resource
#COPY out /opt/resource/out
COPY common.sh /opt/resource/common.sh

#RUN chmod +x /opt/resource/check /opt/resource/in /opt/resource/out

#WORKDIR /opt/resource