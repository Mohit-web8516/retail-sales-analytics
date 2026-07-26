-- Verification checks after loading data

USE RetailAnalytics;
GO

SELECT 
    (SELECT COUNT(*) FROM Customers) AS CustomerCount,
    (SELECT COUNT(*) FROM Products) AS ProductCount,
    (SELECT COUNT(*) FROM Orders) AS OrderCount;

-- Known data quality issue: one order has NULL Profit
SELECT * FROM Orders WHERE Profit IS NULL;