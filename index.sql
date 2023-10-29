--Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL, -- hashed password
    role ENUM('admin', 'user') NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--Items Table
CREATE TABLE Items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    size ENUM('small', 'medium', 'large') NOT NULL,
    category_id INT,
    description TEXT,
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

--Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    status ENUM('pending', 'approved', 'disapproved') DEFAULT 'pending',
    total_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

--OrderItems Table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    sub_total DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

--Inserting Records into Entities
INSERT INTO Users (username, password, role, email) VALUES ('admin', 'hashedpassword', 'admin', 'admin@example.com');
INSERT INTO Categories (category_name, description) VALUES ('Electronics', 'Electronics items');
INSERT INTO Items (name, price, size, category_id, description, stock_quantity) VALUES ('Laptop', 999.99, 'medium', 1, 'A high-end laptop', 10);
INSERT INTO Orders (user_id, total_price) VALUES (1, 999.99);
INSERT INTO OrderItems (order_id, item_id, quantity, sub_total) VALUES (1, 1, 1, 999.99);

--Getting items and their categories
SELECT i.name AS ItemName, c.category_name AS Category FROM Items i INNER JOIN Categories c ON i.category_id = c.category_id;

--Getting user orders
SELECT u.username, o.status, o.total_price FROM Users u INNER JOIN Orders o ON u.user_id = o.user_id WHERE u.username = 'admin';

--Updating user email and item price
UPDATE Users SET email = 'newemail@example.com' WHERE username = 'admin';
UPDATE Items SET price = 899.99 WHERE name = 'Laptop';

--Deleting an order item and an order
DELETE FROM OrderItems WHERE order_item_id = 1;
DELETE FROM Orders WHERE order_id = 1;