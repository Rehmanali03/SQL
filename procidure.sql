select * 
from users;
create table products (
	id int primary key identity,
	name varchar(256),
	price money,
	stock int
);

create table sales (
	product_id int,
	quantity int,
	sold_on datetime 

	foreign key (product_id) references products(id)
);
insert into products values('Tuck', 10, 15),('Zera', 10, 15),
('Choclato', 10, 15),('Click', 10, 15),('Oreo', 10, 15),('Penat', 10, 15);
drop proc min_product;
create proc min_product @quantity int, @product_id int
as 
begin
	 declare @stock int; 
	 select @stock = stock from products where id = @product_id  
	if @quantity <= @stock 
	begin
	insert into sales values(@product_id, @quantity, current_timestamp);
	update products set stock = stock - @quantity where id = @product_id;
	select * from products;
	select * from sales;
	end
	else
		select 'Eror' as massage
end
exec min_product 13, 3;

