-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой
----- компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package
-----(company_name в табл shippers)
SELECT cu.company_name, CONCAT(first_name, ' ', last_name) AS employee_name
FROM orders ord
JOIN customers cu ON ord.customer_id = cu.customer_id
JOIN employees emp ON ord.employee_id = emp.employee_id
JOIN shippers sh ON ord.ship_via = sh.shipper_id
WHERE cu.city = 'London' AND emp.city = 'London' AND sh.company_name = 'United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.phone
SELECT pr.product_name, pr.units_in_stock, supp.contact_name, supp.phone
FROM products pr
JOIN suppliers supp ON pr.supplier_id = supp.supplier_id
WHERE pr.discontinued = 0
AND pr.units_in_stock < 25
AND pr.category_id
IN (SELECT category_id FROM categories WHERE category_name IN ('Dairy Products', 'Condiments'))
ORDER BY pr.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name
FROM customers cu
LEFT JOIN orders ord ON ord.customer_id = cu.customer_id
WHERE ord.order_id IS NULL;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT pr.product_name
FROM products pr
WHERE pr.product_id IN (SELECT product_id FROM order_details WHERE quantity = 10)




