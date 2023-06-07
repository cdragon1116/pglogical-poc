FROM reedws/pglogical

VOLUME ["master_db:/var/lib/postgresql/data/master_db/"]

ENV PGDATA=/var/lib/postgresql/data/master_db/

# Copy Postgres config file into container
COPY postgresql.conf /etc/postgresql
COPY pg_hba.conf /etc/postgresql

RUN rm -f /var/lib/postgresql/data/pg_hba.conf
COPY pg_hba.conf /var/lib/postgresql/data/pg_hba.conf

# Copy sql
COPY provider/init.sql /docker-entrypoint-initdb.d/init.sql
COPY provider/seed.sql /seed.sql
COPY provider/create_replication_set.sql /create_replication_set.sql

# Override default Postgres config file
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
