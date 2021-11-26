# scylladb-csdlpt
install Docker: https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe
- install linux kernel
- (Tải về gói update Linux kernel qua link https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
- Để WSL 2 làm mặc định khi cài đặt Linux distribution:
```
wsl --set-default-version 2
```
# Start: Working with Scylla Database
Link: [here](https://dev.to/j_a_o_v_c_t_r/working-with-scylla-database-3al9)
- Downloading image
```
docker run --name scylla-db-test -d scylladb/scylla:4.1.0
or
docker run --name scyllaU -d scylladb/scylla:4.1.0 --overprovisioned 1 --smp 1 (i)
```
- nodetool (making sure our node is  still up)
```
docker exec -it scyllaU nodetool status (ii)
```
- (skip) nodetool: *getting an error* (Chờ 1->2 phút để node join vào datacenter)
```
nodetool: Unable to connect to Scylla API server: java.net.ConnectException: Connection refused (Connection refused)
See 'nodetool help' or 'nodetool help <command>'.
```
- Finally, we use the CQL Shell to interact with Scylla (Run a CQL shell)
```
docker exec -it scyllaU cqlsh (iii)
```
- Create a keyspace called “mykeyspace”
```
CREATE KEYSPACE mykeyspace WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1};
```
Keep in mind that SimpleStrategy should not be used in production.

-Next, create a table with three columns: user id, first name, and last name, and insert some data:
```
use mykeyspace; 
```
```
CREATE TABLE users ( user_id int, fname text, lname text, PRIMARY KEY((user_id))); 
```
Insert into the newly created table two rows:
```
insert into users(user_id, fname, lname) values (1, 'rick', 'sanchez'); 
insert into users(user_id, fname, lname) values (4, 'rust', 'cohle'); 
```
Read the table contents:
```
select * from users;
```
Result:
```

 user_id | fname | lname
---------+-------+---------
       1 |  rick | sanchez
       4 |  rust |   cohle

(2 rows)
```
*updating*






