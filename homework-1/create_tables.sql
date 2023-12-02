-- SQL-команды для создания таблиц
-- Компании
CREATE TABLE customers
(
  customer_id VARCHAR(5) PRIMARY KEY NOT NULL,
  company_name VARCHAR(50) NOT NULL,
  contact_name VARCHAR(50) NOT NULL
);
-- Сотрудники
CREATE TABLE employees
(
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  title VARCHAR(255) NOT NULL,
  birth_date DATE NOT NULL,
  notes TEXT
);
-- Заказы
CREATE TABLE orders
(
  order_id  INT PRIMARY KEY,
  customer_id VARCHAR(5) REFERENCES customers ON DELETE CASCADE ON UPDATE CASCADE NOT NULL ,
  employee_id INT REFERENCES employees ON DELETE CASCADE ON UPDATE CASCADE NOT NULL ,
  order_date DATE NOT NULL,
  ship_city VARCHAR(30) NOT NULL
);
