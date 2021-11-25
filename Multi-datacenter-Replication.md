1.
```
git clone https://github.com/scylladb/scylla-code-samples.git
```
2. cd
```
cd scylla-code-samples/mms
```
3. Check (cho vui)
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
docker exec -it mms_scylla-node1_1 cqlsh
``` 
=>
```
Connected to  at 172.18.0.4:9042.
[cqlsh 5.0.1 | Cassandra 3.0.8 | CQL spec 3.3.1 | Native protocol v4]
Use HELP for help.
cqlsh>
```
Open: [[Multi-datacenter Replication](https://university.scylladb.com/courses/the-mutant-monitoring-system-training-course/lessons/multi-datacenter-replication/)]
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
15. d
16. d
17. d
18. d
19. d
20. d
