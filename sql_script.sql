-- Mengambil Nama Depan Kontak dan Nama Belakang Kontak dari table Customers
SELECT contactFirstName, contactLastName from customers;

-- Menaikan Buy Price seluruh product sebesar  5%
UPDATE products SET buyPrice = buyPrice * 1.05;

-- Mengambil product yang memiliki stok kurang dari atau sama dengan 1000
Select
    productName,
    quantityInStock
from products
where quantityInStock <= 1000;

-- Mengambil data nama customer beserta sudah berapa tahun order pertama dilakukan
SELECT customerName, (
        select
            FLOOR(
                DATEDIFF(NOW(), orderDate) / 365
            ) YoS
        from orders
        where
            orders.customerNumber = customers.customerNumber
        ORDER BY orderDate asc
        limit 1
    ) as Yos
FROM customers
ORDER BY Yos desc;

-- Mengambil total dari setiap order
Select
    customerName,
    o.orderNumber,
    orderDate, (
        SUM(
            od.priceEach * od.quantityOrdered
        )
    ) as total
from orders o
    INNER JOIN customers c on o.customerNumber = c.customerNumber
    INNER JOIN orderdetails od on o.orderNumber = od.orderNumber
GROUP BY o.orderNumber;

-- Mengambil data pembayaran customer mulai dari yang terbaru
Query : SELECT
	customerName,
	checkNumber,
	paymentDate,
	amount 
FROM
	payments p
	INNER JOIN customers c ON c.customerNumber = p.customerNumber 
ORDER BY
	paymentDate DESC;