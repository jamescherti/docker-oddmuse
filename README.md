# Docker-oddmuse - Oddmuse Docker Container

**Author:** James Cherti

## What is Oddmuse?

Oddmuse is a wiki engine. Unlike other wiki engines that rely on local or remote databases to store and modify content, Oddmuse utilizes the local file system. This means that users can create and manage Wiki pages on their local machine and easily transfer them to other locations or servers. By leveraging the local file system, Oddmuse eliminates the need for complex and costly database setups.

## Installation

### Download the Docker container from Docker hub

The `oddmuse` Docker container can be downloaded from Docker hub using the following command:
``` shell
docker pull jamescherti/oddmuse
```

### Build the Docker container

Alternatively, you can build the `oddmuse` Docker container using the command:

``` shell
docker build -t jamescherti/oddmuse github.com/jamescherti/docker-oddmuse
```

## Usage

``` shell
docker run --rm \
  -v /local/path/oddmuse_data:/data \
  -p 8080:80 \
  --env ODDMUSE_URL_PATH=/wiki \
  jamescherti/oddmuse
```

## License

Distributed under the terms of the MIT license.

## Links
- `docker-oddmuse` Git repository: https://github.com/jamescherti/docker-oddmuse
- `docker-oddmuse` Docker Hub: https://hub.docker.com/r/jamescherti/oddmuse
- Oddmuse website: https://oddmuse.org/
