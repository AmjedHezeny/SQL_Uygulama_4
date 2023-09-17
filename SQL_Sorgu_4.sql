-- Hangi ürünüm hangi kategoridedir.
-- (categories, products)(CategoryName, ProductName)
SELECT
	Products.ProductName,
	Categories.CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

-- Hangi ürünü, hangi tedarikçi sa?l?yor?
-- (products, suppliers)
SELECT
	Products.ProductName,
	Suppliers.CompanyName
FROM Products
INNER JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

-- Çal??anlar?m Ne kadarl?k sat?? yapm??
-- (employees, orders, order details)
SELECT
	(Employees.FirstName + ' ' + Employees.LastName) AS FullName,
	SUM((od.Quantity * od.UnitPrice) * (1 - od.Discount)) AS TotalPrice
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] AS od ON Orders.OrderID = od.OrderID
GROUP BY Employees.FirstName + ' ' + Employees.LastName;

-- Ülkelere göre ne kadarl?k sat?? yapm???m
-- (customers, orders, order details)
SELECT
	Customers.Country,
	SUM((od.Quantity * od.UnitPrice) * (1 - od.Discount)) AS TotalPrice
FROM Customers
INNER JOIN Orders ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details] AS od ON od.OrderID = Orders.OrderID
GROUP BY Customers.Country;

-- Hangi kategoride kaç tane ürün satm???m
-- (categories, products, order details)
SELECT
	Categories.CategoryName,
	SUM(od.Quantity) AS Amount
FROM Categories
INNER JOIN Products ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] AS od ON Products.ProductID = od.ProductID
GROUP BY Categories.CategoryName
ORDER BY Amount;

-- Çal??anlar?m ürün baz?nda ne kadarl?k sat?? yapm??t?r
-- çal??an ad?, ürün ad?, adet, gelir
-- (Employees, orders, order details, products)
SELECT
	(Employees.FirstName + ' ' + Employees.LastName) AS FullName,
	Products.ProductName,
	SUM(od.Quantity) AS Amount,
	SUM((od.Quantity * od.UnitPrice) * (1 - Discount)) AS TotalPrice
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN [Order Details] AS od ON Orders.OrderID = od.OrderID
INNER JOIN Products ON Products.ProductID = od.ProductID
GROUP BY Employees.FirstName + ' ' + Employees.LastName, Products.ProductName
ORDER BY FullName;
