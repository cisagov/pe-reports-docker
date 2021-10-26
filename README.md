# Posture & Exposure Reports Docker🐳 #

[![GitHub Build Status](https://github.com/cisagov/skeleton-docker/workflows/build/badge.svg)](https://github.com/cisagov/skeleton-docker/actions/workflows/build.yml)
[![Coverage Status](https://coveralls.io/repos/github/cisagov/pe-reports-docker/badge.svg?branch=develop)](https://coveralls.io/github/cisagov/pe-reports-docker?branch=develop)
[![CodeQL](https://github.com/cisagov/skeleton-docker/workflows/CodeQL/badge.svg)](https://github.com/cisagov/skeleton-docker/actions/workflows/codeql-analysis.yml)
[![Known Vulnerabilities](https://snyk.io/test/github/cisagov/skeleton-docker/badge.svg)](https://snyk.io/test/github/cisagov/skeleton-docker)

## Docker Image ##

[![Docker Pulls](https://img.shields.io/docker/pulls/cisagov/example)](https://hub.docker.com/r/cisagov/example)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cisagov/example)](https://hub.docker.com/r/cisagov/example)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm%2Fv6%20%7C%20arm%2Fv7%20%7C%20arm64%20%7C%20ppc64le%20%7C%20s390x-blue)](https://hub.docker.com/r/cisagov/skeleton-docker/tags)

This is a Docker skeleton project that can be used to quickly get a
new [cisagov](https://github.com/cisagov) GitHub Docker project
started.  This skeleton project contains [licensing
information](LICENSE), as well as [pre-commit hooks](https://pre-commit.com)
and [GitHub Actions](https://github.com/features/actions) configurations
appropriate for Docker containers and the major languages that we use.

## Running ##

### Running with Docker ###

To run this docker see command below. This docker will check to see if this
docker exists locally and is running. If the docker image exists and
containter is running no further action will be taken. If the docker image
exists and the container is not running. The container will be started.
If the docker does not exists the docker will be created and exectuted, when
complete the shell of the container will be presented at the command line.

```console
python3 ./createDocker.py
```

## Using secrets with your container ##

This container also supports passing sensitive values via [Docker
secrets](https://docs.docker.com/engine/swarm/secrets/).  Passing sensitive
values like your credentials can be more secure using secrets than using
environment variables.  See the
[secrets](#secrets) section below for a table of all supported secret files.

1. To use secrets, create a `quote.txt` file containing the values you want set:

    ```text
    Better lock it in your pocket.
    ```

## Updating your container ##

### Docker Compose ###

1. Pull the new image from Docker Hub:

    ```console
    docker-compose pull
    ```

1. Recreate the running container by following the [previous instructions](#running-with-docker-compose):

    ```console
    docker-compose up --detach
    ```

### Docker ###

1. Stop the running container:

    ```console
    docker stop <container_id>
    ```

## Secrets ##

| Filename     | Purpose |
|--------------|---------|
| `quote.txt` | Replaces the secret stored in the example library's package data. |

## Building from source ##

Build the image locally using this git repository as the [build context](https://docs.docker.com/engine/reference/commandline/build/#git-repositories):

```console
docker build \
  --build-arg VERSION=0.0.1 \
  --tag cisagov/example:0.0.1 \
  https://github.com/cisagov/example.git#develop
```

## Cross-platform builds ##

To create images that are compatible with other platforms, you can use the
[`buildx`](https://docs.docker.com/buildx/working-with-buildx/) feature of
Docker:

1. Copy the project to your machine using the `Code` button above
   or the command line:

    ```console
    git clone https://github.com/cisagov/example.git
    cd example
    ```

1. Build the image using `buildx` modify Dockerfile:

    ```console
    docker buildx build \
      --file Dockerfile-x \
      --platform linux/amd64 \
      --build-arg VERSION=0.0.1 \
      --output type=docker \
      --tag cisagov/example:0.0.1 .
    ```

## New repositories from a skeleton ##

Please see our [Project Setup guide](https://github.com/cisagov/development-guide/tree/develop/project_setup)
for step-by-step instructions on how to start a new repository from
a skeleton. This will save you time and effort when configuring a
new repository!

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
