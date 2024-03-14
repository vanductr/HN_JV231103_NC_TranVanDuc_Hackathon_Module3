# ====== Bài 1: Tạo CSDL =====
CREATE DATABASE QUANLYBANHANG;
USE QUANLYBANHANG;

# Tạo Bảng: CUSTOMERS
CREATE TABLE CUSTOMERS (
    customer_id VARCHAR(4) PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(25) UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL
);

# Tạo Bảng: ORDERS
CREATE TABLE ORDERS (
    order_id VARCHAR(4) PRIMARY KEY NOT NULL,
    customer_id VARCHAR(4) NOT NULL,
    order_date DATE NOT NULL,
    total_amount DOUBLE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
);

# Tạo Bảng: PRODUCTS
CREATE TABLE PRODUCTS (
    product_id VARCHAR(4) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    status BIT(1) NOT NULL
);

# Tạo Bảng: ORDERS_DETAILS
CREATE TABLE ORDERS_DETAILS (
    order_id VARCHAR(4),
    product_id VARCHAR(4),
    quantity INT(11) NOT NULL,
    price DOUBLE NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);


# ======= Bài 2: Thêm dữ liệu =======
# Thêm dữ liệu vào Bảng CUSTOMERS:
INSERT INTO CUSTOMERS (customer_id, name, email, phone, address)
VALUES 
    ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
    ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
    ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904725784', 'Mộc Châu, Sơn La'),
    ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
    ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');
    
# Thêm dữ liệu vào Bảng PRODUCTS:
 INSERT INTO PRODUCTS (product_id, name, description, price, status)
VALUES 
    ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
    ('P002', 'Dell Vostro V3510', 'Core i5, RAM 8GB', 14999999, 1),
    ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB', 28999999, 1),
    ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
    ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);

# Thêm dữ liệu vào Bảng ORDERS:
INSERT INTO ORDERS (order_id, customer_id, total_amount, order_date)
VALUES 
    ('H001', 'C001', 52999997, '2023-02-22'),
    ('H002', 'C001', 80999997, '2023-03-11'),
    ('H003', 'C002', 54359998, '2023-01-22'),
    ('H004', 'C003', 102999995, '2023-03-14'),
    ('H005', 'C003', 80999997, '2022-03-12'),
    ('H006', 'C004', 110449994, '2023-02-01'),
    ('H007', 'C004', 79999996, '2023-03-29'),
    ('H008', 'C005', 29999998, '2023-02-14'),
    ('H009', 'C005', 28999999, '2023-01-10'),
    ('H010', 'C005', 149999994, '2023-04-01');

# Thêm dữ liệu vào Bảng ORDERS_DETAILS:
INSERT INTO ORDERS_DETAILS (order_id, product_id, quantity, price)
VALUES 
    ('H001', 'P002', 1, 14999999),
    ('H001', 'P004', 2, 18999999),
    ('H002', 'P001', 1, 22999999),
    ('H002', 'P003', 2, 28999999),
    ('H003', 'P004', 2, 18999999),
    ('H003', 'P005', 4, 4090000),
    ('H004', 'P002', 3, 14999999),
    ('H004', 'P003', 2, 28999999),
    ('H005', 'P001', 1, 22999999),
    ('H005', 'P003', 2, 28999999),
    ('H006', 'P005', 5, 4090000),
    ('H006', 'P002', 6, 14999999),
    ('H007', 'P004', 3, 18999999),
    ('H007', 'P001', 1, 22999999),
    ('H008', 'P002', 2, 14999999),
    ('H009', 'P003', 1, 28999999),
    ('H010', 'P003', 2, 28999999),
    ('H010', 'P001', 4, 22999999);

# ======= Bài 3: Truy vấn dữ liệu =======
# 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
SELECT name, email, phone, address
FROM CUSTOMERS;

# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
# thoại và địa chỉ khách hàng).
SELECT c.name, c.phone, c.address
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.customer_id = o.customer_id
WHERE MONTH(o.order_date) = 3 AND YEAR(o.order_date) = 2023;

# 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
# tháng và tổng doanh thu ). 
SELECT MONTH(order_date) AS month, SUM(total_amount) AS total_revenue
FROM ORDERS
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date);

# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
# hàng, địa chỉ , email và số điên thoại). 
SELECT name, address, email, phone
FROM CUSTOMERS
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM ORDERS
    WHERE MONTH(order_date) = 2 AND YEAR(order_date) = 2023
);

# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
# sản phẩm, tên sản phẩm và số lượng bán ra). 
SELECT OD.product_id, P.name AS product_name, SUM(OD.quantity) AS total_quantity
FROM ORDERS_DETAILS OD
JOIN ORDERS O ON OD.order_id = O.order_id
JOIN PRODUCTS P ON OD.product_id = P.product_id
WHERE MONTH(O.order_date) = 3 AND YEAR(O.order_date) = 2023
GROUP BY OD.product_id, P.name;

# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
# tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu).
SELECT O.customer_id, C.name AS customer_name, SUM(O.total_amount) AS total_spending
FROM ORDERS O
JOIN CUSTOMERS C ON O.customer_id = C.customer_id
WHERE YEAR(O.order_date) = 2023
GROUP BY O.customer_id, C.name
ORDER BY total_spending DESC;
 
# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
# tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . 
SELECT C.name AS customer_name, O.total_amount, O.order_date, SUM(OD.quantity) AS total_quantity
FROM ORDERS O
JOIN CUSTOMERS C ON O.customer_id = C.customer_id
JOIN ORDERS_DETAILS OD ON O.order_id = OD.order_id
GROUP BY O.order_id, C.name, O.total_amount, O.order_date
HAVING SUM(OD.quantity) >= 5;

# ======= Bài 4: Tạo View, Procedure =======
# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
# tiền và ngày tạo hoá đơn .
CREATE VIEW InvoiceInfo AS
SELECT C.name AS customer_name, C.phone, C.address, O.total_amount, O.order_date
FROM ORDERS O
JOIN CUSTOMERS C ON O.customer_id = C.customer_id;

# 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
# số đơn đã đặt.
CREATE VIEW CustomerInfo AS
SELECT C.name AS customer_name, C.address, C.phone, COUNT(O.order_id) AS total_orders
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.customer_id = O.customer_id
GROUP BY C.customer_id;

# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
# bán ra của mỗi sản phẩm.
CREATE VIEW ProductSalesInfo AS
SELECT P.name AS product_name, P.description, P.price, COALESCE(SUM(OD.quantity), 0) AS total_sold
FROM PRODUCTS P
LEFT JOIN ORDERS_DETAILS OD ON P.product_id = OD.product_id
GROUP BY P.product_id;

# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. 
CREATE INDEX idx_phone ON Customers(phone);
CREATE INDEX idx_email ON Customers(email);

# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.
DELIMITER //

CREATE PROCEDURE GetCustomerInfoById (IN customerId VARCHAR(4))
BEGIN
    SELECT *
    FROM Customers
    WHERE customer_id = customerId;
END //

DELIMITER ;
CALL GetCustomerInfoById('C001');

# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm.
DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM PRODUCTS;
END //

DELIMITER ;
CALL GetAllProducts();

# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng.
DELIMITER //

CREATE PROCEDURE GetOrdersByCustomerId(IN customer_id_param VARCHAR(4))
BEGIN
    SELECT * FROM ORDERS WHERE customer_id = customer_id_param;
END //

DELIMITER ;
CALL GetOrdersByCustomerId('C001');

# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
# tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo.
DELIMITER //

CREATE PROCEDURE CreateOrder(
    IN customer_id_param VARCHAR(4),
    IN total_amount_param DOUBLE,
    IN order_date_param DATE,
    OUT order_id_result VARCHAR(4)
)
BEGIN
    DECLARE max_order_id INT;
    DECLARE new_order_id INT;
    
    -- Tìm mã đơn hàng lớn nhất
    SELECT MAX(CONVERT(SUBSTRING(order_id, 2), UNSIGNED)) INTO max_order_id FROM ORDERS;

    -- Nếu không có đơn hàng nào tồn tại, gán mã đơn hàng mới là 1, ngược lại tăng giá trị lên 1
    IF max_order_id IS NULL THEN
        SET new_order_id = 1;
    ELSE
        SET new_order_id = max_order_id + 1;
    END IF;
    
    -- Tạo mã đơn hàng mới
    SET order_id_result = CONCAT('H', LPAD(new_order_id, 3, '0'));
    
    -- Thêm đơn hàng mới vào bảng ORDERS
    INSERT INTO ORDERS (order_id, customer_id, total_amount, order_date)
    VALUES (order_id_result, customer_id_param, total_amount_param, order_date_param);
END //

DELIMITER ;

CALL CreateOrder('C002', 12000000, '2023-03-15', @order_id_result);
SELECT @order_id_result AS order_id_result;

# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
# thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc.
DELIMITER //

CREATE PROCEDURE SalesStatistics(
    IN start_date_param DATE,
    IN end_date_param DATE
)
BEGIN
    SELECT p.product_id, p.name, p.description, COUNT(od.product_id) AS total_sales
    FROM PRODUCTS p
    LEFT JOIN ORDERS_DETAILS od ON p.product_id = od.product_id
    INNER JOIN ORDERS o ON od.order_id = o.order_id
    WHERE o.order_date BETWEEN start_date_param AND end_date_param
    GROUP BY p.product_id, p.name, p.description;
END //

DELIMITER ;
CALL SalesStatistics('2023-03-01', '2023-03-31');

# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
# giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê.
DELIMITER //

CREATE PROCEDURE SalesStatisticsByMonth(
    IN month_param INT,
    IN year_param INT
)
BEGIN
    SELECT
        P.product_id,
        P.name AS product_name,
        SUM(OD.quantity) AS total_quantity
    FROM
        ORDERS O
    JOIN
        ORDERS_DETAILS OD ON O.order_id = OD.order_id
    JOIN
        PRODUCTS P ON OD.product_id = P.product_id
    WHERE
        MONTH(O.order_date) = month_param
        AND YEAR(O.order_date) = year_param
    GROUP BY
        P.product_id,
        P.name
    ORDER BY
        total_quantity DESC;
END //

DELIMITER ;
CALL SalesStatisticsByMonth(3, 2023);

# ==================================== KẾT THÚC =================================================