#!/bin/bash

gcloud compute instances create reddit-app \
--image reddit-full-1584865321 \
--tags puma-server,http-server
