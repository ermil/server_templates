#!/bin/sh
while inotifywait -e modify -e create /full/path/to/wg0.conf; do
    /full/path/to/docker-compose -f /full/path/to/docker-compose.yml up -d --force-recreate  wireguard wg-gen coredns
done
