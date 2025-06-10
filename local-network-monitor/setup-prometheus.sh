#!/usr/bin/env bash

brew update
brew install prometheus
cp /opt/homebrew/etc/prometheus.yml /opt/homebrew/etc/prometheus.yml.backup
cp prometheus.yml /opt/homebrew/etc/prometheus.yml
brew services restart prometheus
