#!/usr/bin/env bash

# Detect container engine (prefer podman, fallback to docker)
if command -v podman &> /dev/null; then
    COMPOSE="podman compose"
elif command -v docker &> /dev/null; then
    COMPOSE="docker compose"
else
    echo "Error: Neither podman nor docker found. Please install one of them."
    exit 1
fi

$COMPOSE down && $COMPOSE pull && $COMPOSE up -d --build && $COMPOSE logs -f
