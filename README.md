# SPA Seed

This is seed code for a single-page web application.  Use it as an example to
learn from, or a basis for a full SPA of your own.

## Features / Flaws

* Both frontend (client-side / browser) and backend (server-side)
* Authentication using JSON Web Tokens ([JWT](http://jwt.io/))
* Two-way, asynchronous frontend-backend communication (server can push)
* No AJAX, no REST API -- uses websockets for FE-BE communication

## Setup

Put your project's name throughout the repository:

``` bash
    cd /path/to/spa-seed
    find backend -type f -exec sed -i 's/ProjectName/YourActualProjectName/g' {} +
    find backend -type f -exec sed -i 's/project-name/your-actual-project-name/g' {} +
    find backend -type f -exec sed -i 's/PROJECT_NAME/YOUR_ACTUAL_PROJECT_NAME/g' {} +
    git mv backend/lib/project-name backend/lib/your-actual-project-name
    find frontend -type f -exec sed -i 's/ProjectName/YourActualProjectName/g' {} +
```

## Backend

Two-way communication with frontend via websockets.
Data persistence managed by [Sequel](http://sequel.jeremyevans.net/), stored in
[PostgreSQL](http://www.postgresql.org/).

### Requirements

* [Ruby](https://www.ruby-lang.org/)
* [PostgreSQL](http://www.postgresql.org/)
* [PhantomJS](http://phantomjs.org/), optional, for end-to-end testing

It is highly recommended to configure PostgreSQL to allow passwordless local
connections, for convenience's sake.  This is not strictly required, but then
the burden of making DB authentication work properly becomes yours.

### Setup

``` bash
    cd backend
    createuser username_you_made_up
    createdb -O username_you_made_up db_name_you_made_up
    createdb -O username_you_made_up test_db_name_you_made_up
    cp defaults.yaml config.yaml
    ${EDITOR} config.yaml
    # Create gemsets, etc. at this point if desired, then:
    bundle install
    bin/migrate.sh
    PROJECT_NAME_ENV=test bin/migrate.sh
    bin/run-tests.sh
```

### Usage

Start the server with:

``` bash
    bin/start-server.sh
```

Stop the server with SIGINT (Ctrl-C), SIGTERM or SIGKILL.

## Frontend

A Single-Page Application (SPA) built with [Vue.js](http://vuejs.org/) and
websockets.

### Requirements

* [Node.js](https://nodejs.org/) (for npm)

### Setup

``` bash
    cd frontend
    npm install
```

### Usage

Serve for development with hot reload at localhost:8080 :

    npm run dev

Build for production with minification:

    npm run build

This builds the code into the `dist/` dir.  See Production Config Examples,
below.

## Production Config Examples

### Nginx

    server {
      listen 80;
      server_name yourdomain.com;
      root /path/to/spa-seed/frontend/dist;

      access_log /var/log/nginx/yourdomain.com.access_log main;
      error_log /var/log/nginx/yourdomain.com.error_log info;
    }

### Apache

    <VirtualHost *:80>
        ServerName yourdomain.com
        ServerAlias yourdomain.com
        ErrorLog /var/log/apache2/yourdomain.com.errors
        CustomLog /var/log/apache2/yourdomain.com.log combined
        DocumentRoot "/misc/git/spa-seed/frontend/dist"

        <Directory "/path/to/spa-seed/frontend/dist">
            Options Indexes FollowSymLinks -ExecCGI
            AllowOverride All
            Order allow,deny
            Allow from all
        </Directory>
    </VirtualHost>
