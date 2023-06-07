-- create extension
CREATE EXTENSION pglogical;

-- create node
SELECT pglogical.create_node(
  node_name := 'provider',
  dsn := 'host=master_db port=5432 dbname=master_db'
);

-- create replication set
SELECT pglogical.create_replication_set(
  set_name := 'example'
);

-- add tables to replication set
SELECT pglogical.replication_set_add_table(
  set_name := 'example',
  relation := 'users'
);
