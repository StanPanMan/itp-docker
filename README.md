# Docker Static App Deployment
This is a local deployment to serve the GitHub Pages app of [stanpanman.github.io/pages-site/](https://stanpanman.github.io/pages-site/)

## Architecture
- requests to `http://localhost:8081` get routed to the `fp-svc` which has a webserver on port `7901`
    - for `http://fp-svc:7901/`, the container proxies to `http://hp-svc:6969/`
    - for `http://fp-svc:7901/pages-site`, the container serves the pages site stored inside the image at `/usr/share/nginx/html` (this came from a Git repo)
    - the `hp-svc` serves a landing page on port `6969` that comes from a volume and has a link to `http://localhost:8081/pages-site/`



## Prerequisites
- Docker version 27.4.0, build bde2b89
- sh shell with typical tools and perl
## Testing Notes
- Tested on Windows 11 Home
- Tested with Docker version 27.4.0, build bde2b89
- Tested with Git Bash

## Usage
1. Start up Docker Desktop before using docker commands.
2. Initialize the file structure and volumes.
    ```bash
    chmod +x scripts/init.sh;
    ./scripts/init.sh
    ```
3. To Up the compose stack:
    ```bash
    docker compose up -d
    ```
4. Visit the homepage by going to [localhost:8081](http://localhost:8081) in the browser.
5. Click the link you find on the homepage
6. To monitor services, attach to the watchdog and curl different services.
    ```bash
    docker compose attach watchdog-svc;
    ```
    (from inside watchdog-c)
    ```sh
    apk add curl;
    curl http://fp-svc:7901/; # proxied to http://hp-svc:6969/ (homepage)
    curl http://hp-svc:6969/; # hits http://hp-svc:6969/ (homepage)
    curl http://fp-svc:7901/pages-site/ # hit the pages site (pages-site)
    ```
    Use `ctrl-d` to exit and restart that main shell process.
7. To Down the compose stack:
    ```bash
    docker compose down;
    ```
