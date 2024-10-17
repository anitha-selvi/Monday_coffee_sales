create database coffee_db;
use coffee_db;

create table products
(
    product_id	int PRIMARY KEY,
    product_name varchar(50),
    price float
);

create table city
(
   city_id	int PRIMARY KEY,
   city_name varchar(20),
   population	bigint,
   estimated_rent	float,
   city_rank int
);

create table customers
(
   customer_id	int PRIMARY KEY,
   customer_name varchar(30),
   city_id int,
   constraint fk_city foreign key(city_id) references city(city_id)
);

create table sales
(
    sale_id	int PRIMARY KEY, 
    sale_date	date,
    product_id	int,
    customer_id	int,
    total	float,
    rating int,
constraint fk_products foreign key (product_id) references products(product_id),
constraint fk_customers foreign key (customer_id) references customers(customer_id)
);
