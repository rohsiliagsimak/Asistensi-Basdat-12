USE classicmodels

#No 1
SELECT 
		productCode, 
		productName, 
		buyPrice
FROM products
WHERE buyPrice >
(SELECT AVG(buyPrice) 
 FROM products);

#No2
SELECT o.orderNumber, 
		 o.orderDate
FROM orders o
	JOIN customers c
	USING(customerNumber)
WHERE c.salesRepEmployeeNumber IN 
(SELECT e.employeeNumber FROM employees e
	JOIN offices f
	USING (officeCode ) 
WHERE f.city = 'Tokyo');

#no3
SELECT c.customerName, 
		 o.orderNumber, 
		 o.shippedDate, 
		 o.requiredDate, 
		 GROUP_CONCAT(p.productName SEPARATOR ', ') AS product,
		 SUM(od.quantityOrdered) AS total_quantity_ordered, 
		 CONCAT(e.firstName, ' ', e.lastName) AS employeeName
FROM customers c
	JOIN orders o
	USING(customerNumber)
	JOIN orderdetails od
	USING(orderNumber)
	JOIN products p
	USING(productCode)
	JOIN employees e
	ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE o.orderNumber IN 
(SELECT orderNumber FROM orders
 WHERE shippedDate > requiredDate);


#no4
SELECT 
	p.productName,
	p.productLine,
	SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
	JOIN orderdetails od
	USING(productCode)
WHERE p.productLine IN 
(SELECT productline
	FROM (
		SELECT p2.productline FROM products  p2
		JOIN orderdetails od2
		USING(productCode)
		GROUP BY p2.productline
		ORDER BY SUM(od2.quantityOrdered) DESC 
		LIMIT 3
	) AS productLine
)
GROUP BY productName, productline
ORDER BY productline, total_quantity_ordered DESC;