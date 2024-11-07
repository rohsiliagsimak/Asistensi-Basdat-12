-- nomor 1 
CREATE DATABASE db_sepakbola;
USE db_sepakbola;

test

-- Nomor 2
USE classicmodels;

SELECT c.customerName, 
	    c.country, 
		 SUM(p.amount) AS TotalPayment,
		 COUNT(o.orderNumber) AS orderCount,
		 MAX(p.paymentDate) AS LastPaymentDate,
CASE 
	WHEN SUM(p.amount) > 100000 THEN 'VIP'
	WHEN SUM(p.amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
	ELSE 'New'
	END AS 'Status'
FROM customers AS c
LEFT JOIN payments AS p
USING (customerNumber)
LEFT JOIN orders AS o
USING (customerNumber)
GROUP BY c.customerNumber
ORDER BY c.customerName;

-- Nomor 3
SELECT c.customerNumber, c.customerName,
SUM(od.quantityOrdered) AS total_quantity,
CASE
		WHEN SUM(od.quantityOrdered) > (
			SELECT SUM(quantityOrdered) FROM (
				SELECT AVG(quantityOrdered) AS quantityOrdered
				FROM orderdetails AS od
			) AS tabel
		) THEN 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
		END AS 'kategori_pembelian'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
GROUP BY c.customerNumber
ORDER BY total_quantity DESC;



-- nomor tambahan ----
-- no1
START TRANSACTION;

INSERT INTO klub (nama_klub, kota_asal)
VALUES ('Persija', 'Jakarta'),
		 ('Arema FC', 'Malang'),
		 ('Persebaya', 'Surabaya'),
		 ('PSM Makassar', 'Makassar'),
		 ('Bali United', 'Bali');

SELECT * FROM klub;

INSERT INTO pemain (nama_pemain, posisi, id_klub )
VALUES ('Evan Dimas', 'Midfielder', 1),
		 ('Riko Simanjuntak', ' Defender', 1),
		 ('Hanif Sjahbandi', 'Surabaya', 2),
		 ('Makan Konate', 'Midfielder', 2),
		 ('David da Silva', 'Forward', 3),
		 ('Irfan Jaya','Forward', 4),
		 ('Rizky Pellu','Midfielder', 4),
		 ('Ilija Spasojevic','Forward', 5),
		 ('Andhika Wijaya','Defender', 5);
SELECT * FROM pemain;

INSERT INTO pertandingan (tanggal_pertandingan, id_klub_tuan_rumah, skor_tuan_rumah,skor_tamu, id_klub_tamu)
VALUES ('2024-09-10', 1, 2, 1, 2),
		 ('2024-09-12', 3, 1, 4, 1),
		 ('2024-09-15', 5, 0, 3, 1),
		 ('2024-09-20', 2, 1, 2, 5),
		 ('2024-09-25', 4, 2, 0, 3);

SELECT * FROM pertandingan;
SELECT * FROM pemain;
SELECT * FROM klub;

ROLLBACK;

COMMIT;












































