SELECT *
FROM sys.tables

create table test (
	id int primary key identity,
	sub1 int,
	sub2 int,
	sub3 int,
	sub4 int
);
create table test_total(
	id int FOREIGN KEY REFERENCES test(id),
	total_numbers int
);
create trigger tr_insert_test
on test 
after insert 
as 
begin
	declare @total int;
	declare @pk_test int;

	select @total = i.sub1+i.sub2+i.sub3+i.sub4 from inserted as i;
	select @pk_test = id from inserted;

	insert into test_total values(@pk_test, @total);
end
insert into test values(30, 40, 50, 60);

select * from test;
select * from test_total;
create trigger tr_update_test
on test 
after update
as 
begin
	declare @total int;
	declare @pk_test int;

	select @total = i.sub1+i.sub2+i.sub3+i.sub4 from inserted as i;
	select @pk_test = id from inserted;

	update test_total set total_numbers = @total where id = @pk_test;
end
update test set sub1 = 60 where id = 1