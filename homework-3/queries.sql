-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника,
--    работающего над заказом этой компании (см таблицу employees),
--    когда и заказчик и сотрудник зарегистрированы в городе London,
--    а доставку заказа ведет компания United Package (company_name в табл shippers)
select cust.company_name as customer,
CONCAT(emp.first_name, ' ', emp.last_name) as employee
from orders ord
	inner join employees emp
		on ord.employee_id = emp.employee_id
		and emp.city = 'London'
	inner join customers cust
		on ord.customer_id = cust.customer_id
		and cust.city = 'London'
	inner join shippers sh
		on ord.ship_via = sh.shipper_id
		and sh.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
--    имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
--    которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях
--    Dairy Products и Condiments.
--    Отсортировать результат по возрастанию количества оставшегося товара.
select pr.product_name, pr.units_in_stock, s.contact_name, s.phone
from products pr
	inner join suppliers s
		using(supplier_id)
	inner join categories cat
		on pr.category_id = cat.category_id
		and (category_name = 'Dairy Products'
		or category_name = 'Condiments')
where pr.discontinued <> 1 and pr.units_in_stock < 25
order by pr.units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select cus.company_name
from customers cus
	left join orders ord
		using(customer_id)
where ord.customer_id is null

-- 4. Уникальные названия продуктов, которых заказано ровно 10 единиц
--    (количество заказанных единиц см в колонке quantity табл order_details)
--    Этот запрос написать именно с использованием подзапроса.
select pr.product_name
from products pr
where exists(
	select 1 from order_details od
	where od.quantity = 10
	and pr.product_id = od.product_id
)