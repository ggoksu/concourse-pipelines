FROM concourse/docker-image-resource

RUN wget -O pack.tar.tgz 'https://github.com/buildpack/pack/releases/download/v0.1.0/pack-v0.1.0-linux.tgz' \
  && tar xzf pack.tar.tgz -C /usr/local/bin \
  && rm pack.tar.tgz

ADD build /usr/bin/build
