
```
1.scylla-node1:
2.    image: scylladb/scylla:4.4.0
3.    restart: always
4.    command: --seeds=scylla-node1,scylla-node2 --smp 1 --memory 750M --overprovisioned 1 --api-address 0.0.0.0
5.    volumes:
6.      - "./scylla/scylla.yaml:/etc/scylla/scylla.yaml"
7.      - "./scylla/cassandra-rackdc.properties.dc1:/etc/scylla/cassandra-rackdc.properties"
8.      - "./scylla/mutant-data.txt:/mutant-data.txt"
9.    networks:
10.      web:
```
1: Node name
2: Image: auto
3: ...
4: Create node & memory, address
5: config
9: ...
