=> Query: catalog

select * from employee;
select * from employee where id='1' ALLOW FILTERING;
select * from employee where sex='female' ALLOW FILTERING;
select * from employee where sex='male' and address='Ho Chi Minh City' ALLOW FILTERING;

/////////////////////////////////////////////////////////////////////////////////////////

select * from catalog.employee;
select * from catalog.employee where id='1' ALLOW FILTERING;
select * from catalog.employee where sex='female' ALLOW FILTERING;
select * from catalog.employee where sex='male' and address='Ho Chi Minh City' ALLOW FILTERING;

=> Query: tracking

select * from tracking_salary;
select * from tracking_salary where id='1' ALLOW FILTERING;
select * from tracking_salary where first_name='An' ALLOW FILTERING;
select * from tracking_salary where salary>10000000 ALLOW FILTERING;

/////////////////////////////////////////////////////////////////////////////////////////

select * from tracking.tracking_salary;
select * from tracking.tracking_salary where id='1' ALLOW FILTERING;
select * from tracking.tracking_salary where first_name='An' ALLOW FILTERING;
select * from tracking.tracking_salary where salary>10000000 ALLOW FILTERING;
