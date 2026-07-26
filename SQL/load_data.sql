-- Populate normalized tables from Staging_Superstore
-- Note: Used GROUP BY + MAX() instead of DISTINCT for Customers because
-- some CustomerIDs had conflicting values across rows, which violated
-- the PRIMARY KEY constraint on a plain DISTINCT insert.

USE RetailAnalytics;
GO

INSERT INTO Customers (CustomerID, CustomerName, Segment, Country, City, State, PostalCode, Region)
SELECT Customer_ID, 
       MAX(Customer_Name), 
       MAX(Segment), 
       MAX(Country), 
       MAX(City), 
       MAX(State), 
       MAX(CAST(Postal_Code AS VARCHAR(20))), 
       MAX(Region)
FROM Staging_Superstore
GROUP BY Customer_ID;

INSERT INTO Products (ProductID, Category, SubCategory, ProductName)
SELECT Product_ID, 
       MAX(Category), 
       MAX(Sub_Category), 
       MAX(Product_Name)
FROM Staging_Superstore
GROUP BY Product_ID;

INSERT INTO Orders (RowID, OrderID, OrderDate, ShipDate, ShipMode, CustomerID, ProductID, Sales, Quantity, Discount, Profit)
SELECT Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Product_ID, Sales, Quantity, Discount, Profit
FROM Staging_Superstore;