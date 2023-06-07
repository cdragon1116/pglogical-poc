FROM postgres:13

VOLUME ["slave_db:/var/lib/postgresql/data/slave_db/"]

ENV PGDATA=/var/lib/postgresql/data/slave_db/

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    postgresql-13-pglogical \
    postgresql-13-pglogical-ticker

# Copy Postgres config file into container
COPY postgresql.conf /etc/postgresql
COPY pg_hba.conf /etc/postgresql

RUN rm -f /var/lib/postgresql/data/pg_hba.conf
COPY pg_hba.conf /var/lib/postgresql/data/pg_hba.conf

# Copy init sql
COPY subscriber/init.sql /docker-entrypoint-initdb.d/init.sql
COPY subscriber/seed.sql /seed.sql
COPY subscriber/create_subscription_set.sql /create_subscription_set.sql

# Override default Postgres config file
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
