USE classicmodels;

#nomor 1

SELECT 
productCode AS 'Kode Produk',
productName AS 'Nama Produk',
quantityInStock AS 'Jumlah Stok'
FROM products 
WHERE quantityInStock >=5000 AND quantityInStock <=6000;

#nomor 2

SELECT 
orderNumber AS 'Nomor Pesanan',
orderDate AS 'Tanggal Pesanan', 
STATUS,
customerNumber AS 'Nomor Pelanggan'
FROM orders
WHERE STATUS != 'shipped'
ORDER BY customerNumber ASC;

#nomor 3

SELECT 
employeeNumber AS 'Nomor Karyawan',
firstName,
lastName, 
email,
jobTitle AS 'Jabatan'
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName
LIMIT 10;

#nomor 4

SELECT 
productCode AS 'Kode Produk',
productName AS 'Nama Produk',
productLine AS 'Lini Produk',
buyPrice AS 'Harga Beli'
FROM products
ORDER BY buyprice DESC
LIMIT 5,10;

#nomor 5

SELECT DISTINCT country ,city 
FROM customers
ORDER BY country, city;

#soal Tambahan
SELECT *FROM employees 
WHERE firstName = 'Gerard';

SELECT 
customerName 'Nama Kustomer',
city 'Kota',
country 'Negara',
salesRepEmployeeNumber 'Nomor Karyawan'
FROM customers 
WHERE salesRepEmployeeNumber = 1370;
