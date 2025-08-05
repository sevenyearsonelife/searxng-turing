#!/bin/bash

PORT=9088
INSTANCE_NAME="Turing-instance"
BIND_ADDRESS="10.4.85.77"

docker run --rm \
    -d -p ${PORT}:8080 \
    -v "${PWD}/searxng:/etc/searxng" \
    -e "BASE_URL=http://${BIND_ADDRESS}:${PORT}/" \
    -e "INSTANCE_NAME=${INSTANCE_NAME}" \
    searxng/searxng

