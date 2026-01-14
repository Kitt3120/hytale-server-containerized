#!/usr/bin/env bash

podman compose down && podman compose pull && podman compose up -d --build && podman compose logs -f
