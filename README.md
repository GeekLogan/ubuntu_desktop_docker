# ubuntu_desktop_docker
*A Docker image which allows you to run a full GUI ubuntu installation via VNC*

## To build
`docker build -t ubuntu_desktop_docker .`

## To run
`docker run --privileged -it ubuntu_desktop_docker:latest /bin/bash`

During the startup process, a log line similar to the following should be printed:
`Connect to 172.17.0.2:5900`

Use that address to connect to the vnc server

## Default login information
```
Username: ubuntu
Password: ubuntu
```
