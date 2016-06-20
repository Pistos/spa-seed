Database <---> Backend <---> Frontend, FE, FE, ...

## Database

PostgreSQL.  Emits NOTIFY events.

## Backend

* Listens for NOTIFY events.
* has models with associations
* informs UDBs about table record upserts and deletions
* an upsert to one record also sends upsert notifications for associated child records

### UserDataBroker (UDB)

* receives frontend requests
* has Array of all the websockets for one specific user
* broadcasts backend updates to frontends through the websockets
* controls/limits frontend visibility of and access to DB data

## Frontend

* maintains a copy/cache (data store) of a portion of backend data
* uses websockets to interact with backend
* watches estimated data store size
* frees data store data in a LRU fashion
* has models with associations; the same schema as in the backend
