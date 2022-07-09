FROM alpine:3.16.0

# Install the most used languages on the docker image
RUN apk add --no-cache \
  bash \
  curl \
  git \
  wget \
  unzip \
  zip \
  py-pip \
  nodejs \
  ruby \
  rust \
  gcc \
  elixir \
  gfortran

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
