ARG VERSION=unspecified

FROM ubuntu:20.04

ARG VERSION

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="mark.feldhousen@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

ARG DEBIAN_FRONTEND=noninteractive

ARG CISA_UID=421
ENV CISA_HOME="/home/cisa"
ENV ECHO_MESSAGE="Hello World from Dockerfile"

RUN addgroup --system --gid ${CISA_UID} cisa \
  && adduser --system --uid ${CISA_UID} --ingroup cisa cisa


RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
USER root
RUN apt-get update -y && apt-get install -y --no-install-recommends \
        python3.9 \
        nano \
        python3-pip \
        build-essential \
        ca-certificates \
        curl \
        git \
        libbz2-dev \
        libffi-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        liblzma-dev \
        libssl-dev \
        llvm \
        make \
        netbase \
        pkg-config \
        postgresql \
        postgresql-contrib \
        cron \
        tk-dev \
        wget \
        xz-utils \
        zlib1g-dev \
        libxml2-dev \
        libxmlsec1-dev

RUN mkdir .pyenv
RUN chmod 775 .pyenv
RUN chmod 644 /root/.bashrc
RUN service postgresql start

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
RUN $SHELL


RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
RUN $SHELL

#RUN pyenv install 3.9.7

RUN mkdir /usr/src/pe-reports
RUN echo 'alias python=python3' >> ~/.bashrc
RUN git clone https://github.com/cisagov/pe-reports.git /usr/src/pe-reports/
RUN mkdir /run/secrets
COPY requirements.txt /usr/src/pe-reports/
WORKDIR /usr/src/pe-reports
EXPOSE 5000

RUN pip install --upgrade pip
