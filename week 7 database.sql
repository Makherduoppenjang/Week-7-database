
-- =====================================================
-- WEEK 7 ASSIGNMENT
-- DATABASE DESIGN AND NORMALIZATION
-- =====================================================


-- =====================================================
-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)
-- =====================================================

-- Step 1: Remove the table if it already exists
DROP TABLE IF EXISTS ProductDetail_1NF;

-- Step 2: Create a new normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),

    PRIMARY KEY (OrderID, Product)
);

-- Step 3: Insert normalized records
INSERT INTO ProductDetail_1NF
    (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Step 4: Display the 1NF table
SELECT * FROM ProductDetail_1NF;


-- =====================================================
-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)
-- =====================================================

-- Partial Dependency:
-- CustomerName depends only on OrderID,
-- not on the entire composite key (OrderID, Product).
-- Therefore, we separate order information from order items.


-- Step 1: Remove existing tables if they exist
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;

-- Step 2: Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 3: Create the OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT NOT NULL,

    PRIMARY KEY (OrderID, Product),

    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);

-- Step 4: Insert records into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 5: Insert records into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- Step 6: Display the Orders table
SELECT * FROM Orders;

-- Step 7: Display the OrderItems table
SELECT * FROM OrderItems;

-- Step 8: Display combined order information
SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
INNER JOIN OrderItems
    ON Orders.OrderID = OrderItems.OrderID;


-- =====================================================
-- END OF WEEK 7 ASSIGNMENT
-- =====================================================
