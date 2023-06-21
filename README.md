# ubuntu_desktop_docker
*A Docker image which allows you to run a full GUI ubuntu installation via VNC*

## To build
`docker build -t ubuntu_desktop_docker .`

## To run
`docker run --privileged -it ubuntu_desktop_docker:latest /bin/bash`
