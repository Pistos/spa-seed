# SPA Seed

## Features

* Both frontend (client-side / browser) and backend (server-side)
* Authentication using JSON Web Tokens ([JWT](http://jwt.io/))

## Backend

A REST API served by [Grape](https://github.com/ruby-grape/grape).
Data persistence managed by [Sequel](http://sequel.jeremyevans.net/), stored in
[PostgreSQL](http://www.postgresql.org/).

### Requirements

* Ruby
* PostgreSQL

It is highly recommended to configure PostgreSQL to allow passwordless local
connections, for convenience sake.  This is not strictly required, but then
the burden of making DB authentication work properly becomes yours.

### Setup

``` bash
    cd backend
    createuser username_you_made_up
    createdb -O username_you_made_up db_name_you_made_up
    cp defaults.yaml config.yaml
    ${EDITOR} config.yaml
    # Create gemsets, etc. at this point if desired, then:
    bundle install
    ./migrate.sh
```

### Usage

Then start the server with:

    ./start-server.sh

Stop the server with SIGINT (Ctrl-C).

## Frontend

A Single-Page Application (SPA) built with [Vue](http://vuejs.org/).

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
