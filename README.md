# Docker Static App Deployment

Haha this is from PHP branch. More from php.

This is a local deploymnet to run server-side php scripts integrated with an NGINX web server.

## Architecture

TBD


## Prerequisites
- Docker version 27.4.0, build bde2b89
- sh shell with typical tools and perl
## Testing Notes
- Tested on Windows 11 Home
- Tested with Docker version 27.4.0, build bde2b89
- Tested with Git Bash

## Usage
1. Initialize the file structure and volumes.
    ```bash
    chmod +x scripts/init.sh;
    ./scripts/init.sh
    ```
2. Some manual changes TB Documented
2. To Up the compse stack:
    ```bash
    docker compose up -d
    ```
3. To Down the compose stack:
    ```bash
    docker compose down;
    ```