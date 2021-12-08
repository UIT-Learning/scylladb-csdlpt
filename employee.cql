CREATE KEYSPACE catalog WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy','DC1' : 3};

use catalog;

CREATE TABLE employee (
    id varchar,
    first_name text,
    last_name text,
    sex text,
    dob timestamp,
    phone_number varchar,
    salary double,
    address text,
    PRIMARY KEY((id, first_name, last_name))
);

insert into employee ("id","first_name","last_name", "sex", "dob", "phone_number", "salary", "address") VALUES ('1', 'An', 'Nguyen Van', 'male', '2000-11-11 08:05+0000', '0123333333', 5000000.0, 'Ho Chi Minh City');
insert into employee ("id","first_name","last_name", "sex", "dob", "phone_number", "salary", "address") VALUES ('2', 'Chau', 'Nguyen Thi', 'female', '2001-11-5 08:05+0000', '0123333444', 9600000.0, 'Ha Noi City');
insert into employee ("id","first_name","last_name", "sex", "dob", "phone_number", "salary", "address") VALUES ('3', 'Hoang', 'Tran Van', 'male', '2000-4-11 08:05+0000', '0123333555', 7200000.0, 'Da Nang City');
insert into employee ("id","first_name","last_name", "sex", "dob", "phone_number", "salary", "address") VALUES ('4', 'Dat', 'Hoang Chi', 'male', '2001-3-12 08:05+0000', '0123333666', 4800000.0, 'Thanh Hoa');
insert into employee ("id","first_name","last_name", "sex", "dob", "phone_number", "salary", "address") VALUES ('5', 'Long', 'Vo Nam', 'male', '2000-9-11 08:05+0000', '0123333777', 7200000.0, 'Hue');
insert into employee ("id","first_name","last_name", "sex", "dob", "phone_number", "salary", "address") VALUES ('6', 'Trang', 'Tran Thu', 'female', '2000-9-11 08:05+0000', '0123333888', 7200000.0, 'Hue');


CREATE KEYSPACE tracking WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy','DC1' : 3};

use tracking;

CREATE TABLE tracking_salary (
    id varchar,
    first_name text,
    last_name text,
    timestamp timestamp,
    salary double,
    primary key((id, first_name, last_name), timestamp)
    )
    WITH CLUSTERING ORDER BY (timestamp DESC)
    AND COMPACTION = 
        {
            'class': 'DateTieredCompactionStrategy',
            'base_time_seconds': 3600,
            'max_sstable_age_days': 1
        };

INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('6','Trang','Tran Thu','2017-11-11 08:05+0000',5000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('6','Trang','Tran Thu','2017-11-11 09:05+0000',5200000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('6','Trang','Tran Thu','2017-11-11 10:05+0000',5400000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('6','Trang','Tran Thu','2017-11-11 10:22+0000',6200000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('6','Trang','Tran Thu','2017-11-11 11:05+0000',8000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('6','Trang','Tran Thu','2017-11-11 12:05+0000',11000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('1','An','Nguyen Van','2017-11-11 08:05+0000',5000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('1','An','Nguyen Van','2017-11-11 09:05+0000',7000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('1','An','Nguyen Van','2017-11-11 10:05+0000',7500000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('1','An','Nguyen Van','2017-11-11 10:22+0000',8200000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('1','An','Nguyen Van','2017-11-11 11:05+0000',1200000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('1','An','Nguyen Van','2017-11-11 12:05+0000',15000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('2','Chau','Nguyen Thi','2017-11-11 08:05+0000',5000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('2','Chau','Nguyen Thi','2017-11-11 09:05+0000',7000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('2','Chau','Nguyen Thi','2017-11-11 10:05+0000',7500000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('2','Chau','Nguyen Thi','2017-11-11 10:22+0000',8000000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('2','Chau','Nguyen Thi','2017-11-11 11:05+0000',1100000) ;
INSERT INTO tracking.tracking_salary ("id","first_name","last_name","timestamp","salary") VALUES ('2','Chau','Nguyen Thi','2017-11-11 12:05+0000',13000000) ;
