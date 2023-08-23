CREATE DATABASE COMPANY
USE COMPANY
DROP TABLE MANUFACTURER
DROP TABLE EMPLOYEE
DROP TABLE COMPUTER
CREATE TABLE MANUFACTURER
(
	Mfname VARCHAR(20) PRIMARY KEY,
	City VARCHAR(20),
	State VARCHAR(20)
)

CREATE TABLE EMPLOYEE
(
	EmployeeID INT PRIMARY KEY,
	EmpName VARCHAR(20),
	Area_code VARCHAR(20),
	Phone VARCHAR(10),
	Email VARCHAR(25)
)
CREATE TABLE COMPUTER(
	SerialNumber INT PRIMARY KEY,
	Mfname VARCHAR(20),
	Model VARCHAR(20),
	Weight DECIMAL(4,2),
	EmployeeID INT,
	CONSTRAINT fk_mfname FOREIGN KEY(Mfname) REFERENCES
	MANUFACTURER(Mfname),
	CONSTRAINT fk_empid FOREIGN KEY(EmployeeID) REFERENCES
	EMPLOYEE(EmployeeID)
)


INSERT INTO Manufacturer (MfName, city, state)
VALUES
    ('Akhil', 'south dakota', 'africa'),
    ('Rahul', 'kollam', 'kerala'),
    ('Ravi', 'kochi', 'kerala');

INSERT INTO Computer (SerialNumber, Model, weight, EmployeeId, MfName)
VALUES
    (101, 'Model1', 12.5, 1, 'Akhil'),
    (102, 'Model2', 28.2, 2, 'Rahul'),
    (103, 'Model3', 13.7, 3, 'Ravi');

INSERT INTO Employee (EmployeeId, EmpName, area_code, phone, email)
VALUES
    (1, 'Joseph', '505', '9987675423', 'joseph@gmail.com'),
    (2, 'Jake', '206', '9876456342', 'jake@gmail.com'),
    (3, 'Adam', '345', '9364536789', 'adam@gmail.com');

--Q1

SELECT MfName
FROM Manufacturer
WHERE city = 'South Dakota';

--Q2

SELECT AVG(Weight)AS 'average weight' FROM COMPUTER;

--Q3

SELECT EmpName FROM EMPLOYEE WHERE Area_Code LIKE '2%';

--Q4

SELECT SerialNumber
FROM Computer
WHERE weight < (SELECT AVG(weight) FROM Computer);

--Q5

SELECT MfName FROM MANUFACTURER WHERE MfName NOT IN (SELECT MfName FROM COMPUTER) 

--Q6

SELECT e.EmpName, c.SerialNumber, m.city FROM EMPLOYEE e
JOIN COMPUTER c ON e.EmployeeID = c.EmployeeID
JOIN MANUFACTURER m ON c.MfName = m.MfName

--Q7

create procedure getDetails
    @EmployeeId int
as
begin
    select Computer.SerialNumber, Manufacturer.mfname, Model, weight
    from computer
    join employee on Computer.EmployeeId = Employee.EmployeeId
    join manufacturer on Computer.MfName = Manufacturer.MfName
    WHERE Employee.EmployeeId =@EmployeeId;
END;
  exec getDetails @employeeid=3

