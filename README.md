# hytale-server-containerized

Easy to use Hytale server as a container. This does **not** produce an image, but rather bootstraps Hytale inside a Debian container.

## Prerequisites

- Docker or Podman installed on your system (scripts auto-detect which is available)
- Compose working with your container engine
- You have read [Hytale's Server Setup Guide](https://support.hytale.com/hc/en-us/articles/45326769420827-Hytale-Server-Manual#running-a-hytale-server)
- Firewall allows 5520 UDP (or your specified port)

## How to use

1. Clone this repository to your local machine:

   ```bash
   git clone git@github.com:Kitt3120/hytale-server-containerized.git
   cd hytale-server-containerized
   ```

2. Bring up the container

   ```bash
   ./start.sh
   ```

3. Authenticate your server according to Hytale's Server Setup Guide.
4. Enjoy!

## Scripts

- `start.sh`: Starts/Restarts the server and attaches to the logs. Quit with `CTRL+C`.
- `stop.sh`: Stops the server container
- `logs.sh`: Attaches to the server logs. Quit with `CTRL+C`.
- `attach.sh`: Attaches to the server console. Quit with `CTRL+P+Q`.
- `data/bootstrap.sh`: The bootstrap script that runs inside the container on each start

## Updating the server

Updating the server on each boot would add a lot of unnecessary time to startup.
Instead, the bootstrap script checks for a new version only if `data/hytale.zip` is missing.
Delete `data/hytale.zip` and run `start.sh` again to update to the latest version.

## Known problems

- `stop.sh` shuts down the container, resulting in Docker/Podman sending a SIGTERM to the server process.
  However, the Hytale server does not handle SIGTERM properly yet.
  After a timeout, the container engine forcefully kills the process.
  This may lead to data loss or even corruption.

- No automatic update check on each start.

- You have to authenticate the server on each start.
  This is a limitation by Hytale for now.
  As a workaround, it would be possible to acquire a token using curl before the server starts, and pass it as an environment variable.
  This is documented in [Hytale's Server Provider Authentication Guide](https://support.hytale.com/hc/en-us/articles/45328341414043-Server-Provider-Authentication-Guide).

## Contributing

This is far from perfect, but it gets the job done.
Feel free to fork and submit pull requests with improvements!
