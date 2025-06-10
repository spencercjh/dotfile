#!/usr/bin/env bash
set -ex

# Remove existing container if it exists
docker rm -f blackbox-exporter 2>/dev/null || true

docker run -d \
  -p 9115:9115 \
  -v "$(pwd)/blackbox.yml":/config/blackbox.yml \
  --name blackbox-exporter \
  quay.io/prometheus/blackbox-exporter:latest \
  --config.file=/config/blackbox.yml
