#!/usr/bin/env bash
docker run -d \
  -p 9115:9115 \
  -v "$(pwd)/blackbox.yml":/config/blackbox.yml \
  --name blackbox-exporter \
  quay.io/prometheus/blackbox-exporter:latest \
  --config.file=/config/blackbox.yml
