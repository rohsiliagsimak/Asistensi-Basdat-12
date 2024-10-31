-- nomor 1
(SELECT 
	p.productName, 
	SUM(od.priceEach * od.quantityOrdered) 
	AS TotalRevenue, 
	'Pendapatan Tertinggi' AS Pendapatan 
FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders 
	USING(orderNumber)
WHERE MONTH(orderDate) = 09
GROUP BY p.productName
ORDER BY TotalRevenue DESC
LIMIT 5)

UNION
 
(SELECT 
	p.productName, 
	SUM(od.priceEach * od.quantityOrdered) 
	AS TotalRevenue, 
	'Pendapatan Pendek (Kayak Kamu)'
	AS Pendapatan 
FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders 
	USING(orderNumber)
WHERE MONTH(orderDate) = 09
GROUP BY p.productName
ORDER BY TotalRevenue ASC
LIMIT 5);

-- nomor 2
SELECT p.productName 
FROM products p 

EXCEPT
 
SELECT DISTINCT p.productName
FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	JOIN customers c
	USING(customerNumber)
WHERE c.customerNumber IN (
	SELECT c2.customerNumber 
	FROM customers c2
	JOIN orders o2
	USING(customerNumber)
	JOIN orderdetails od2
	USING(orderNumber)
	WHERE od2.priceEach > 
	(SELECT AVG(priceEach)
	FROM orderdetails)
	GROUP BY c2.customerNumber
	HAVING COUNT(DISTINCT od2.orderNumber) > 10
);

-- nomor 3
SELECT c.customerName
FROM customers c
	JOIN payments p
	USING(customerNumber)
	JOIN orders o
	USING(customerNumber)
	JOIN orderdetails od
	USING(orderNumber)
	JOIN products pr
	USING(productCode)
WHERE pr.productLine LIKE '%Planes%' 
GROUP BY c.customerName
HAVING SUM(p.amount) > (
	SELECT AVG(amount)* 2
	FROM payments)
	AND SUM(od.priceEach) > 20000
	
UNION

SELECT c.customerName
FROM customers c
	JOIN payments p
	USING(customerNumber)
	JOIN orders o
	USING(customerNumber)
	JOIN orderdetails od
	USING(orderNumber)
	JOIN products pr
	USING(productCode)
WHERE pr.productLine LIKE '%Trains%'
GROUP BY c.customerName
HAVING SUM(p.amount) > (
	SELECT AVG(amount)* 2
	FROM payments)
	AND SUM(od.priceEach) > 20000;

-- nomor 4
SELECT DISTINCT
	o.orderDate AS Tanggal,
	c.customerNumber,
	'Membayar Pesanan dan Memesan Barang' AS riwayat
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN payments p
ON o.orderDate = p.paymentDate
WHERE o.orderDate LIKE '2003-09%'

UNION 

SELECT 
	o.orderDate,
	customerNumber,
	'Memesan Barang'
FROM orders o
WHERE o.orderDate LIKE '2003-09%'
AND o.orderDate NOT IN (
	SELECT p2.paymentDate 
	FROM payments p2
)

UNION

SELECT 
	p.paymentDate,
	customerNumber,
	'Membayar Pesanan'
FROM payments p 
WHERE p.paymentDate LIKE '2003-09%'
AND p.paymentDate NOT IN (
	SELECT o2.orderDate
	FROM orders o2
)
ORDER BY Tanggal;

-- nomor 5
SELECT productCode 
FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
WHERE p.buyPrice > (
	SELECT AVG(p2.buyPrice)
	FROM products p2
	JOIN orderdetails od2
	USING(productCode)
	JOIN orders o2
	USING(orderNumber)
	WHERE o2.orderDate BETWEEN '2001-01-01'
	AND '2004-03-31'
)
AND od.quantityOrdered > 48 
AND LEFT(p.productVendor, 1) IN 
('a', 'i', 'u', 'e', 'o')

EXCEPT 

SELECT productCode 
FROM products p
	JOIN orderdetails od
	USING(productCode)
	JOIN orders o
	USING(orderNumber)
	JOIN customers c
	USING(customerNumber)
	WHERE c.country IN ('germany', 'japan', 'italy')
	ORDER BY productCode

