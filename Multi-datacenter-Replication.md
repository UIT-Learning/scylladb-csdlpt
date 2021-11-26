1.
```
git clone https://github.com/scylladb/scylla-code-samples.git
```
2. cd
```
cd scylla-code-samples/mms
```
3. Check version Docker (cho vui)
```
docker-compose --version
```
4.
```
docker-compose up -d
```
=> 
```
[+] Running 4/4
 - Network mms_web               Created                                                                                                                   1.0s
 - Container mms-scylla-node3-1  Started                                                                                                                   3.9s
 - Container mms-scylla-node2-1  Started                                                                                                                   3.9s
 - Container mms-scylla-node1-1  Started                                                                                                                   3.9s
```
5. 
```
docker exec -it mms-scylla-node1-1 nodetool status
```
=>
```
Using /etc/scylla/scylla.yaml as the config file
Datacenter: DC1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns    Host ID                               Rack
UN  172.18.0.2  201.18 KB  256          ?       5bcdb413-5167-4984-b8d1-e511f7594ef3  Rack1
UN  172.18.0.3  ?          256          ?       57ed1b4e-0d7e-439f-aef0-51a40c1c392c  Rack1
UN  172.18.0.4  195.65 KB  256          ?       1ebc07d4-afe3-4453-af62-88097c33d916  Rack1
```
6. 
```
docker exec -it mms-scylla-node1-1 cqlsh
``` 
=>
```
Connected to  at 172.18.0.4:9042.
[cqlsh 5.0.1 | Cassandra 3.0.8 | CQL spec 3.3.1 | Native protocol v4]
Use HELP for help.
cqlsh>
```
Open: [[Multi-datacenter Replication](https://university.scylladb.com/courses/the-mutant-monitoring-system-training-course/lessons/multi-datacenter-replication/)].

7. The first task is to create the keyspace for the catalog.
```
CREATE KEYSPACE catalog WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy','DC1' : 3};
```
8. Now that the keyspace is created, it is time to create the table.
```
use catalog;
```
9. 
```

CREATE TABLE mutant_data (
   first_name text,
   last_name text,
   address text,
   picture_location text,
   PRIMARY KEY((first_name, last_name)));
```
10. Now let’s add a few mutants to the catalog with the following statements:
```
insert into mutant_data ("first_name","last_name","address","picture_location") VALUES ('Bob','Loblaw','1313 Mockingbird Lane', 'http://www.facebook.com/bobloblaw');
insert into mutant_data ("first_name","last_name","address","picture_location") VALUES ('Bob','Zemuda','1202 Coffman Lane', 'http://www.facebook.com/bzemuda');
insert into mutant_data ("first_name","last_name","address","picture_location") VALUES ('Jim','Jeffries','1211 Hollywood Lane', 'http://www.facebook.com/jeffries');
```
11. Next, create the Tracking keyspace:
```
CREATE KEYSPACE tracking WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy','DC1' : 3};
```
12. Now we can create the tracking table:
```
use tracking;
```
13.
```
CREATE TABLE tracking_data (
       first_name text,
       last_name text,
       timestamp timestamp,
       location varchar,
       speed double,
       heat double,
       telepathy_powers int,
       primary key((first_name, last_name), timestamp))
       WITH CLUSTERING ORDER BY (timestamp DESC)
       AND COMPACTION = {'class': 'DateTieredCompactionStrategy',
           'base_time_seconds': 3600,
           'max_sstable_age_days': 1};
```
14. Now that the table is created, let’s insert data into the tracking_data table:
```
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Jim','Jeffries','2017-11-11 08:05+0000','New York',1.0,3.0,17) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Jim','Jeffries','2017-11-11 09:05+0000','New York',2.0,4.0,27) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Jim','Jeffries','2017-11-11 10:05+0000','New York',3.0,5.0,37) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Jim','Jeffries','2017-11-11 10:22+0000','New York',4.0,12.0,47) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Jim','Jeffries','2017-11-11 11:05+0000','New York',4.0,9.0,87) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Jim','Jeffries','2017-11-11 12:05+0000','New York',4.0,24.0,57) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Bob','Loblaw','2017-11-11 08:05+0000','Cincinatti',2.0,6.0,5) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Bob','Loblaw','2017-11-11 09:05+0000','Cincinatti',4.0,1.0,10) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Bob','Loblaw','2017-11-11 10:05+0000','Cincinatti',6.0,1.0,15) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Bob','Loblaw','2017-11-11 10:22+0000','Cincinatti',8.0,3.0,6) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Bob','Loblaw','2017-11-11 11:05+0000','Cincinatti',10.0,2.0,3) ;
INSERT INTO tracking.tracking_data ("first_name","last_name","timestamp","location","speed","heat","telepathy_powers") VALUES ('Bob','Loblaw','2017-11-11 12:05+0000','Cincinatti',12.0,10.0,60) ;
```
15. at scylla-code-samples/mms
```
docker-compose -f docker-compose-dc2.yml up -d
```
16. After about 60 seconds, you should be able to see DC1 and DC2 when running the “nodetool status” command:
```
docker exec -it mms-scylla-node1-1 nodetool status
```
=>
```
Datacenter: DC1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns    Host ID                               Rack
UN  172.20.0.4  111.23 KB  256          ?       eaabc5db-61ff-419b-b1a7-f70af23edb1b  Rack1
UN  172.20.0.5  127.09 KB  256          ?       bace1b4e-67c6-4bdb-8eba-398162b7b56e  Rack1
UN  172.20.0.3  111.26 KB  256          ?       b9ea3516-5e1e-4ffb-abff-c6a6701cb41b  Rack1
Datacenter: DC2
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns    Host ID                               Rack
UN  172.20.0.6  110.59 KB  256          ?       bda5fb11-9369-48fb-91be-82c8d821f758  Rack1
UN  172.20.0.7  110.58 KB  256          ?       2ff18950-8547-4ca8-891a-b816a60072e2  Rack1
UN  172.20.0.2  115.36 KB  256          ?       c208d68b-07b7-4167-94e8-d40311082e5d  Rack1
```
## Configuring the keyspaces for Multi-DC
17. 
```
docker exec -it mms-scylla-node1-1 cqlsh
```
18. 
```
ALTER KEYSPACE catalog WITH REPLICATION = {'class': 'NetworkTopologyStrategy', 'DC1':3, 'DC2':3};
```
19. 
```
ALTER KEYSPACE tracking WITH REPLICATION = {'class': 'NetworkTopologyStrategy', 'DC1':3, 'DC2':3};
```
20. Additionally, we need to convert the system keyspaces:
```
ALTER KEYSPACE system_auth WITH replication = { 'class' : 'NetworkTopologyStrategy', 'DC1' : 3, 'DC2' : 3};
```
21. 
```
ALTER KEYSPACE system_distributed WITH replication = { 'class' : 'NetworkTopologyStrategy', 'DC1' : 3, 'DC2' : 3};
```
22. 
```
ALTER KEYSPACE system_traces WITH replication = { 'class' : 'NetworkTopologyStrategy', 'DC1' : 3, 'DC2' : 3};
```
23. 
```
exit
```
## rebuild
24. 
```
docker exec -it mms-scylla-node4-1 nodetool rebuild -- DC1
```
25. 
```
docker exec -it mms-scylla-node5-1 nodetool rebuild -- DC1
```
26. 
```
docker exec -it mms-scylla-node6-1 nodetool rebuild -- DC1
```
27. After that command is run, the data from the first datacenter will be streamed to the second, and no output should be displayed from the terminal. Let’s make sure that our keyspaces are accessible from the second datacenter with the following commands:
```
docker exec -it mms-scylla-node4-1 cqlsh
```
29. 
```
describe catalog;
```
=>
```
CREATE KEYSPACE catalog WITH replication = {'class': 'NetworkTopologyStrategy', 'DC1': '3', 'DC2': '3'}  AND durable_writes = true;

CREATE TABLE catalog.mutant_data (
    first_name text,
    last_name text,
    address text,
    picture_location text,
    PRIMARY KEY ((first_name, last_name))
) WITH bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'class': 'SizeTieredCompactionStrategy'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';
```

30. 
```
describe tracking;
```
=>
```
CREATE KEYSPACE tracking WITH replication = {'class': 'NetworkTopologyStrategy', 'DC1': '3', 'DC2': '3'}  AND durable_writes = true;

CREATE TABLE tracking.tracking_data (
    first_name text,
    last_name text,
    timestamp timestamp,
    heat double,
    location text,
    speed double,
    telepathy_powers int,
    PRIMARY KEY ((first_name, last_name), timestamp)
) WITH CLUSTERING ORDER BY (timestamp DESC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'ALL'}
    AND comment = ''
    AND compaction = {'base_time_seconds': '3600', 'class': 'DateTieredCompactionStrategy', 'max_sstable_age_days': '1'}
    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99.0PERCENTILE';
```
31. 
```
select * from catalog.mutant_data;
```
=>
```
 first_name | last_name | address               | picture_location
------------+-----------+-----------------------+-----------------------------------
        Bob |    Loblaw | 1313 Mockingbird Lane | http://www.facebook.com/bobloblaw
      Steve |      Jobs |          1 Apple Road |      http://www.facebook.com/jobs
        Jim |  Jeffries |   1211 Hollywood Lane |  http://www.facebook.com/jeffries
        Bob |    Zemuda |     1202 Coffman Lane |   http://www.facebook.com/bzemuda

(4 rows)
```
32. 
```
select * from tracking.tracking_data;
```
=>
```
 first_name | last_name | timestamp                       | heat | location   | speed | telepathy_powers
------------+-----------+---------------------------------+------+------------+-------+------------------
        Bob |    Loblaw | 2017-11-11 12:05:00.000000+0000 |   10 | Cincinatti |    12 |               60
        Bob |    Loblaw | 2017-11-11 11:05:00.000000+0000 |    2 | Cincinatti |    10 |                3
        Bob |    Loblaw | 2017-11-11 10:22:00.000000+0000 |    3 | Cincinatti |     8 |                6
        Bob |    Loblaw | 2017-11-11 10:05:00.000000+0000 |    1 | Cincinatti |     6 |               15
        Bob |    Loblaw | 2017-11-11 09:05:00.000000+0000 |    1 | Cincinatti |     4 |               10
        Bob |    Loblaw | 2017-11-11 08:05:00.000000+0000 |    6 | Cincinatti |     2 |                5
        Jim |  Jeffries | 2017-11-11 12:05:00.000000+0000 |   24 |   New York |     4 |               57
        Jim |  Jeffries | 2017-11-11 11:05:00.000000+0000 |    9 |   New York |     4 |               87
        Jim |  Jeffries | 2017-11-11 10:22:00.000000+0000 |   12 |   New York |     4 |               47
        Jim |  Jeffries | 2017-11-11 10:05:00.000000+0000 |    5 |   New York |     3 |               37
        Jim |  Jeffries | 2017-11-11 09:05:00.000000+0000 |    4 |   New York |     2 |               27
        Jim |  Jeffries | 2017-11-11 08:05:00.000000+0000 |    3 |   New York |     1 |               17

(12 rows)
```
33. 
```
```
