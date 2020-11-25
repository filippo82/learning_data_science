# Resources

## Articles

* [Containers bring a skinny new world of virtualization to Linux](http://www.itworld.com/article/2698646/virtualization/containers-bring-a-skinny-new-world-of-virtualization-to-linux.html)
* [What are containers and why do you need them?](http://www.cio.com/article/2924995/enterprise-software/what-are-containers-and-why-do-you-need-them.html)

* [Why we don't let non-root users run Docker in CentOS, Fedora, or RHEL](https://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-users-run-docker-in-centos-fedora-or-rhel/)



* [Source code](https://bitbucket.org/epobb/dockerbookfiles) from [educative.io course](https://www.educative.io/courses/docker-for-developers)


## Commands

## Images

### Pull an image

```
docker pull nginx:1.10.0
```

## Build

### Build an image

```
docker build --tag test-image:1.0 .
```

### Run an image

```
docker run --name repo alpine/git clone https://github.com/docker/getting-started.git
docker cp repo:/git/getting-started/ .
```

```
docker run -d -p 80:80 --name docker-tutorial docker101tutorial
```

### Explore an image

```
docker exec -t -i mycontainer /bin/bash
```

## Tagging

### Tag an image
```
docker tag monolith:1.0.0 your_username/monolith:1.0.0
```

## Push images
Create account on Dockerhub
To be able to push images to Dockerhub you need to create an account there - https://hub.docker.com/register/

### Login and use the docker push command

```
docker login
docker push your_username/monolith:1.0.0
```

## Volumes

### Create a named volume

```
docker volume create todo-db
docker run -dp 3000:3000 -v todo-db:/etc/todos getting-started
```

### Inspect a named volume

```
docker volume inspect todo-db
```
