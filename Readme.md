# pglogical-poc

uses PostgresSQL 13 with pglogical 2.3.3.

## Setup

- start containers
```bash
docker-compose up -d
```

- seed database

```bash
docker exec -it master_db \
  psql -U postgres -d master_db -f /seed.sql

docker exec -it slave_db \
  psql -U postgres -d slave_db -f /seed.sql
```

- create replication set on master_db

```bash
docker exec -it master_db \
  psql -U postgres -d master_db -f /create_replication_set.sql
```

- create subscription set on slave_db

```bash
docker exec -it slave_db \
  psql -U postgres -d slave_db -f /create_subscription_set.sql
```


- check if the correct number of users was replicated
```bash
docker exec -it master_db \
  psql -U postgres -d master_db -c "SELECT * FROM users"

docker exec -it slave_db \
  psql -U postgres -d slave_db -c "SELECT * FROM users"
```


## Test real-time data replication

- create new data in master db

```bash
docker exec -it master_db \
  psql -U postgres -d master_db -c "INSERT INTO users (email, name) VALUES('test5@gmail.com','Hello');"
```

- verify data in slave db

```
docker exec -it slave_db \
  psql -U postgres -d slave_db -c "SELECT * FROM users"
```

## Conflict resolution

For more conflict resolution strategies, please check https://github.com/2ndQuadrant/pglogical#conflicts.

### Test apply_remote

- set conflict strategy to `apply_remote`

```bash
docker exec -it slave_db \
  psql -U postgres -d slave_db -c "set pglogical.conflict_resolution = 'apply_remote'"
```

- insert a record in slave db
```bash
docker exec -it slave_db \
  psql -U postgres -d slave_db -c "INSERT INTO users (id, email, name) VALUES(100, 'test100@gmail.com','Hello');"
```

- check data in slave db

```
docker exec -it slave_db \
  psql -U postgres -d slave_db -c "SELECT * FROM users"
```

- insert a conflict record in master_db

```bash
docker exec -it master_db \
  psql -U postgres -d master_db -c "INSERT INTO users (email, name) VALUES('test100@gmail.com','Hello');"
```

- check master db record

```
docker exec -it master_db \
  psql -U postgres -d master_db -c "SELECT * FROM users"
```

- check slave_db record

```bash
docker exec -it slave_db \
           psql -U postgres -d slave_db -c "SELECT * FROM users"
```


## Useful SQLs

Please see `debug.sql`.
