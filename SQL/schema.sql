-- Retail Sales & Customer Analytics
-- Database schema: normalized Customers, Products, Orders tables

/*USE RetailAnalytics;
GO

-- Drop tables if they already exist (drop in reverse order due to foreign keys)
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
GO

CREATE TABLE Customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Region VARCHAR(50)
);

CREATE TABLE Products (
    ProductID VARCHAR(30) PRIMARY KEY,
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    ProductName VARCHAR(255)
);

CREATE TABLE Orders (
    RowID INT PRIMARY KEY,
    OrderID VARCHAR(20),
    OrderDate DATE,
    ShipDate DATE,
    ShipMode VARCHAR(50),
    CustomerID VARCHAR(20),
    ProductID VARCHAR(30),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,2) NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);*/

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------

