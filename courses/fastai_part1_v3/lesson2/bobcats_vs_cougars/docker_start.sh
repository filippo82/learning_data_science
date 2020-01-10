#!/bin/bash

docker container run --publish 8000:8008 --detach --name cou cougar:0.1
firefox localhost:8000
