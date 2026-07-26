----Query 1 — Monthly Revenue Trend
/*USE RetailAnalytics;
GO

SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(Sales) AS TotalRevenue,
    SUM(Profit) AS TotalProfit
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;*/



------------------------------------------------------
-----------------------------------------------------
------------------------------------------------------
---Query 2 — Top 10 Products by Sales

/*SELECT TOP 10 
    p.ProductName,
    p.Category,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductName, p.Category
ORDER BY TotalSales DESC;*/


-----------------------------------------\
-------------------------------------------
--Query 3 — Regional Performance


/*SELECT 
    c.Region,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit,
    COUNT(DISTINCT o.OrderID) AS TotalOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Region
ORDER BY TotalSales DESC;*/

--------------------------------------------
---------------------------------------------
-----------------------------------------------

--Query 4 — Discount vs Profit Relationship (your strongest insight)

/*SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount > 0 AND Discount <= 0.2 THEN 'Low (0-20%)'
        WHEN Discount > 0.2 AND Discount <= 0.4 THEN 'Medium (20-40%)'
        ELSE 'High (40%+)'
    END AS DiscountBand,
    COUNT(*) AS NumOrders,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    AVG(Profit) AS AvgProfitPerOrder
FROM Orders
GROUP BY 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount > 0 AND Discount <= 0.2 THEN 'Low (0-20%)'
        WHEN Discount > 0.2 AND Discount <= 0.4 THEN 'Medium (20-40%)'
        ELSE 'High (40%+)'
    END
ORDER BY AvgProfitPerOrder DESC;*/

----------------------------------------------
----------------------------------------------
---Query 5 — Top 10 Customers by Revenue
/*SELECT TOP 10
    c.CustomerName,
    c.Segment,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit,
    COUNT(DISTINCT o.OrderID) AS TotalOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName, c.Segment
ORDER BY TotalSales DESC;*/
