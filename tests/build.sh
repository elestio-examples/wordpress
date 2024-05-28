#!/usr/bin/env bash
cp latest/php8.3/apache/* ./
docker buildx build . --output type=docker,name=elestio4test/wordpress:latest | docker load