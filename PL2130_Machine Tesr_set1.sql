CREATE DATABASE Chocolate

USE Chocolate;

CREATE TABLE Item(
	Item_id INT PRIMARY KEY,
	Item_name VARCHAR(15)
);

CREATE TABLE Shop(
	Shop_id INT PRIMARY KEY,
	Shop_name VARCHAR(25)
);

CREATE TABLE Unit_details(
	Unit_id INT PRIMARY KEY,
	Unit VARCHAR(20),
	Count INT
)
CREATE TABLE Sales_order_details(
	Item_id INT,
	shop_id INT,
	Quantity INT,
	Unit_id INT,
	Unit_price INT,
	sale_date DATE,
	CONSTRAINT fk_item FOREIGN KEY(Item_id) REFERENCES Item(Item_id),
	CONSTRAINT fk_shop FOREIGN KEY(shop_id) REFERENCES Shop(shop_id),
	CONSTRAINT fk_unit FOREIGN KEY(Unit_id) REFERENCES Unit_details(unit_id)
);
INSERT INTO Item(Item_id,Item_name)
VALUES (1,'Bar-One'),(2,'KitKat'),(3,'MilkyBar'),
(4,'Munch')

INSERT INTO Shop(Shop_id,Shop_name)
VALUES (1,'Amal Stores'),(2,'Jyothi Stores'),(3,'Indira Stores')

INSERT INTO Unit_details
VALUES(1,'Piece',1),
(2,'Box Pack',28)

INSERT INTO Sales_order_details(Item_id,shop_id,Quantity,Unit_id,Unit_price,sale_date)
VALUES (1,1,100,1,10,'2018-10-05'),
(2,1,200,1,15,'2018-10-05'),
(3,1,50,1,5,'2018-10-05'),
(4,1,150,1,10,'2018-10-05'),
(1,2,10,2,280,'2018-10-10'),
(2,2,30,2,420,'2018-10-10'),
(3,2,40,2,140,'2018-10-10'),
(4,2,20,2,280,'2018-10-10'),
(1,3,50,2,280,'2018-09-15'),
(2,3,70,2,420,'2018-09-15'),
(3,3,30,2,140,'2018-10-10'),
(1,1,150,1,10,'2018-09-15'),
(2,1,250,1,15,'2018-09-15'),
(4,1,200,1,10,'2018-10-10')

SELECT * FROM Item
SELECT * FROM Shop


--Q1.2

SELECT TOP 1 Item_name,SUM(Quantity*Unit_price) AS revenue FROM Item i
INNER JOIN Sales_order_details s
ON i.Item_id = s.Item_id 
WHERE MONTH(sale_date) =10
GROUP BY i.Item_name
ORDER BY revenue DESC

--Q1.3
SELECT TOP 1 I.Item_name,SUM(SO.Quantity) AS TotalQuantitySold
FROM
    Item AS I
INNER JOIN Sales_order_details AS SO ON I.Item_id = SO.Item_id
INNER JOIN Shop AS S ON SO.shop_id = S.Shop_id
WHERE
    DATEPART(MONTH,SO.sale_date) =10
	AND SO.shop_id= 1
GROUP BY
    I.Item_name
ORDER BY
    TotalQuantitySold DESC

--Q1.4
SELECT
    I.Item_name,
    SUM(S.Unit_price * S.Quantity) AS TotalRevenue
FROM
    Sales_order_details S
INNER JOIN ITEM I ON S.Item_id = I.Item_id
WHERE
    DATEPART(MONTH,S.sale_date) = 10
GROUP BY
    I.Item_name
HAVING
    SUM(S.Unit_price * S.Quantity) > 10000


--Q1.5

SELECT TOP 1
    SP.Shop_name,
    SUM(S.Unit_price * S.Quantity) AS TotalRevenue
FROM
    Sales_order_details S
INNER JOIN SHOP SP ON S.Shop_id = SP.Shop_id
WHERE
    DATEPART(MONTH,S.sale_date) = 10
GROUP BY
    SP.Shop_name
ORDER BY 
TotalRevenue DESC










