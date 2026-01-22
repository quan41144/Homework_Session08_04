create database Homework_session08_04;
-- create table
create table products(
	id serial primary key,
	name varchar(100),
	price numeric,
	discount_percent int
);
insert into products (name, price, discount_percent) values
('Laptop Dell XPS 15', 1500.00, 10),
('iPhone 15 Pro Max', 1200.00, 0),
('Chuột Logitech MX Master 3', 99.99, 15),
('Bàn phím cơ Keychron K2', 85.00, 5),
('Màn hình LG UltraGear 27"', 350.00, 20),
('Tai nghe Sony WH-1000XM5', 348.00, 10),
('Loa Bluetooth JBL Flip 6', 129.95, 0),
('Đồng hồ Apple Watch Series 9', 399.00, 5),
('Sạc dự phòng Anker 20000mAh', 45.00, 25),
('Ổ cứng SSD Samsung 1TB', 89.99, 30),
('Webcam Logitech C920', 65.00, 12),
('Ghế công thái học Herman Miller', 1200.00, 0),
('Giá đỡ Laptop nhôm', 25.50, 50),
('Cáp USB-C 2m', 15.00, 0),
('Máy tính bảng iPad Air 5', 599.00, 8);

select * from products;

create or replace procedure calculate_discount(
	p_id int,
	out p_final_price numeric
)
language plpgsql
as $$
declare
	v_price numeric;
	v_discount_percent int;
begin
	select price, discount_percent into v_price, v_discount_percent
	from products
	where id = p_id;
	if (v_discount_percent > 50) then
		v_discount_percent := 50;
	end if;
	p_final_price := v_price - (v_price * v_discount_percent / 100);

	update products
	set price = p_final_price
	where id = p_id;

	raise notice 'Sản phẩm có id: % giảm giá % chỉ còn % (giá gốc: %)', p_id, v_discount_percent, p_final_price, v_price;
end;
$$;
-- Gọi thử
call calculate_discount(9, 0);
select * from products where id = 9;