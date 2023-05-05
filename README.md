# training-sql-1

## Database Schema
![image](https://user-images.githubusercontent.com/20274245/236401536-f2032dbb-6cfe-4fb6-aa3b-55e443f4402c.png)

## Jumlah Data
![image](https://user-images.githubusercontent.com/20274245/236401589-64b03eb7-d5cd-4f06-8418-cbf8f9f36997.png)

## Query 
- Mengambil Nama Depan Kontak dan Nama Belakang Kontak dari table Customers
  
  ``` sql
  SELECT contactFirstName, contactLastName from customers;
  ```
  
  ![image](https://user-images.githubusercontent.com/20274245/236402746-c54cdd42-6961-4ec2-9ba4-c7511016c4d4.png)


- Menaikan Buy Price seluruh product sebesar  5%
  
  ``` sql
  UPDATE products SET buyPrice = buyPrice * 1.05;
  ```
  ![image](https://user-images.githubusercontent.com/20274245/236402794-57a2dd4a-beb4-409c-8f88-e893f759c725.png)

  - Data sebelum update
    ![image](https://user-images.githubusercontent.com/20274245/236402816-2320d39c-9717-4ed7-85bf-8a3468bac841.png)

  - Data Setelah Update
    ![image](https://user-images.githubusercontent.com/20274245/236402836-cbaade46-b901-4d9a-a7f8-992eca55d23c.png)

 
- Mengambil product yang memiliki stok kurang dari atau sama dengan 1000
  
  ``` sql
  Select productName, quantityInStock from products where quantityInStock <= 1000;
  ```
  ![image](https://user-images.githubusercontent.com/20274245/236402912-0c3678e4-e17e-4c2b-b87e-ba4991630d96.png)

  
- Mengambil data nama customer beserta sudah berapa tahun order pertama dilakukan

  ``` sql
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
  ```
 ![image](https://user-images.githubusercontent.com/20274245/236402963-8711c97f-b24a-48b8-aecd-c404df07cc31.png)


- Mengambil total dari setiap order
  ``` sql
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
  ```
 ![image](https://user-images.githubusercontent.com/20274245/236402995-622ca59a-1b9a-4a8b-9563-0e858f01f89d.png)


- Mengambil data pembayaran customer mulai dari yang terbaru
  ```sql
  SELECT
    customerName,
    checkNumber,
    paymentDate,
    amount 
  FROM
    payments p
    INNER JOIN customers c ON c.customerNumber = p.customerNumber 
  ORDER BY
    paymentDate DESC;
  ```
 ![image](https://user-images.githubusercontent.com/20274245/236403024-b96d61e6-35f0-4131-bd71-870172746a57.png)

