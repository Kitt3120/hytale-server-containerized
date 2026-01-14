#!/usr/bin/env bash

# Detect container engine (prefer podman, fallback to docker)
if command -v podman &> /dev/null; then
    ENGINE="podman"
elif command -v docker &> /dev/null; then
    ENGINE="docker"
else
    echo "Error: Neither podman nor docker found. Please install one of them."
    exit 1
fi

RUNNING_CONTAINERS=$($ENGINE ps --filter "name=hytale-server" --format "{{.Names}}")
if [ -z "$RUNNING_CONTAINERS" ]; then
    echo "Error: Hytale server container is not running. Please start it first."
    exit 1
fi

$ENGINE logs "hytale-server" --tail 50
$ENGINE attach "hytale-server"