#!/usr/bin/env bash

podman logs server_hytale_1 --tail 50
podman attach server_hytale_1
