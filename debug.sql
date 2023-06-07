-- check lags
select   pid, client_addr, state, sync_state,
         pg_wal_lsn_diff(sent_lsn, write_lsn) as write_lag,
         pg_wal_lsn_diff(sent_lsn, flush_lsn) as flush_lag,
         pg_wal_lsn_diff(sent_lsn, replay_lsn) as replay_lag
from pg_stat_replication;

--  check replication status of your table
SELECT sub.sub_name, sync_kind, sync_relname, sync_status
  FROM pglogical.local_sync_status stat
  JOIN pglogical.subscription sub ON sub.sub_id = stat.sync_subid
  WHERE sync_status!='r'


-- get node info
select * from pglogical.pglogical_node_info();

-- change conflict strategy
set pglogical.conflict_resolution = 'apply_remote'

-- show subscription status
SELECT * FROM pglogical.show_subscription_status(
  subscription_name := 'pglogical_subscription'
);

-- show subscription table
SELECT * FROM pglogical.show_subscription_table(
  subscription_name := 'pglogical_subscription',
  relation := 'users'
);

-- show `pglogical` relations
\dt pglogical.

-- check local sync status on subscriber
\d+ pglogical.local_sync_status

-- show local sync status
SELECT sync_status
  FROM pglogical.local_sync_status
  WHERE sync_nspname = 'public' AND sync_relname = 'example';

-- check replication slots on provider
SELECT * FROM pg_replication_slots;

-- check replication status on provider
SELECT * FROM pg_stat_replication;
