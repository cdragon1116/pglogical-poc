-- create extension
CREATE EXTENSION pglogical;

-- create node
SELECT pglogical.create_node(
  node_name := 'subscriber',
  dsn := 'host=slave_db port=5432 dbname=slave_db user=postgres password=postgres'
);

-- create subscription
SELECT pglogical.create_subscription(
  subscription_name := 'pglogical_subscription',
  replication_sets := array['example'],
  provider_dsn := 'host=master_db port=5432 dbname=master_db user=postgres password=postgres'
);

SELECT pglogical.wait_for_subscription_sync_complete('pglogical_subscription');
