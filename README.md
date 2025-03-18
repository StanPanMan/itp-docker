# Docker Static App Deployment

This is a local deploymnet to run server-side php scripts integrated with an NGINX web server.

## Architecture

An NGINX container serves HTTP traffic on prot 8080 and uses a PHP-FPM container to run the PHP scripts.
php uses the MySQL db to handle database access by calling `db-svc` on the port specified in the `.env` file

## Prerequisites
- Docker version 27.4.0, build bde2b89
- sh shell with typical tools
## Testing Notes
- Tested on Windows 11 Home
- Tested with Docker version 27.4.0, build bde2b89
- Tested with Git Bash

## Usage
1. Rename [db.env.template](db.env.template) to be called `db.env` and customize the username, password, and port.
2. Initialize the file structure and volumes.
    ```bash
    chmod +x scripts/init.sh;
    ./scripts/init.sh
    ```
    **Note**: be sure to rerun this if you want to delete the data for the db so that it will initilize on up-ing the stack.
3. To Up the compse stack:
    ```bash
    docker compose up -d
    ```
4. Visit the homepage by going to [localhost:8080](http://localhost:8080) in the browser.
5. Click the link you find on the homepage. You should see the PHP info with some purple coloring.
6. To Down the compose stack:
    ```bash
    docker compose down;
    ```