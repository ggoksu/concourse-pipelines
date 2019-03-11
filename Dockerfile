FROM concourse/docker-image-resource

RUN wget -O pack.tar.tgz 'https://github.com/buildpack/pack/releases/download/v0.0.9/pack-0.0.9-linux.tar.gz' \
  && tar xzf pack.tar.tgz -C /usr/local/bin \
  && rm pack.tar.tgz

ADD build /usr/bin/build
