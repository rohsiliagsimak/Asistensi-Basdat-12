USE classicmodels;

#nomor1
SELECT DISTINCT 
	c.customerName AS namaKustomer,
	p.productName AS namaProduk,
	pr.textDescription
FROM customers c
INNER JOIN orders o
		ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails det
		ON o.orderNumber = det.orderNumber
INNER JOIN products p
		ON det.productCode = p.productCode
INNER JOIN productlines pr
		ON p.productLine = pr.productLine
WHERE productname LIKE '%Titanic%'
ORDER BY customername;


#nomor2
SELECT c.customerName ,
		 productName, 
		 o.STATUS, 
		 o.shippedDate
FROM customers c
INNER JOIN orders o
		ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails det
		ON o.orderNumber = det.orderNumber
INNER JOIN products p
		ON det.productCode = p.productCode
WHERE productName LIKE '%ferrari%' 
AND STATUS = 'Shipped' 
AND shippedDate BETWEEN '2003-10-01' AND '2004-10-01'
ORDER BY shippedDate DESC;

#nomor3
SELECT
    s.firstName AS Supervisor,
    k.firstName AS Karyawan
FROM employees k
INNER JOIN employees s
    	ON k.reportsTo = s.employeeNumber
WHERE s.firstName LIKE 'Gerard'
ORDER BY k.firstName ASC; 

#nomor4
#bagian a#
SELECT c.customerName, 
		 p.paymentDate, 
		 e.firstName AS employeeName,
		 p.amount
FROM customers c
INNER JOIN employees e 
		ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN payments p
		ON c.customerNumber = p.customerNumber
WHERE paymentDate LIKE '%-11-%';

#bagian b#
SELECT c.customerName, 
		 p.paymentDate, 
		 e.firstName AS employeeName,
		 p.amount
FROM customers c
INNER JOIN employees e 
		ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN payments p
		ON c.customerNumber = p.customerNumber
WHERE paymentDate LIKE '%-11-%'
ORDER BY amount DESC 
LIMIT 1;



#bagian c#
SELECT c.customerName,
		 p.productName
FROM customers c
INNER JOIN orders o
		ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails det
		ON o.orderNumber = det.orderNumber
INNER JOIN products p
		ON det.productCode = p.productCode
WHERE  customerName = 'corporate gift ideas co.';






