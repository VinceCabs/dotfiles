# Docker Snippets

`docker info`

`sudo docker image prune -a` : delete all unused Docker images and free space

`docker image ls` : list downloaded or built images

`docker container ls --all` : list containers

`docker ps [--all]` : list running containers [or all containers]

`docker build -t=image_name .` : build image from a `Dockerfile` in current directory

`docker run -it <hash> /bin/bash` : run bash on image `<hash>`

![image](https://user-images.githubusercontent.com/35730716/116262751-18917780-a779-11eb-9099-40fad73dc366.png)
