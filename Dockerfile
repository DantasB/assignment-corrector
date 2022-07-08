FROM alpine:3.16.0

# Install the most used languages on the docker image
RUN apk add --no-cache \
  bash \
  curl \
  git \
  python3 \
  python3-pip \
  python3-venv \
  wget \
  golang \
  nodejs \
  openjdk8-jre-headless \
  ruby \
  rust \
  julia \
  mono-complete \
  gcc \
  elixir \
  r-base \
  haskell-platform \
  dask-scheduler \
  dask-worker \
  asm-gcc \
  gfortran

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
