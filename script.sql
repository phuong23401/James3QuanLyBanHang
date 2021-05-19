CREATE TABLE `customer`(
`cID` INT PRIMARY KEY,
`name` VARCHAR(25),
`cAge` TINYINT
);

CREATE TABLE `order`(
`oID` INT PRIMARY KEY,
`cID` INT,
`oDate` DATE,
`oTotalPrice` INT,
FOREIGN KEY (`cID`) REFERENCES `customer`(`cID`)
);

CREATE TABLE `product`(
`pID` INT PRIMARY KEY,
`pName` VARCHAR(25),
`pPrice` INT
);

CREATE TABLE `orderDetails`(
`oID` INT,
`pID` INT,
`odQTY` INT,
FOREIGN KEY (`oID`) REFERENCES `order`(`oID`),
FOREIGN KEY (`pID`) REFERENCES `product`(`pID`)
);

INSERT INTO `customer` VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO `order` VALUES
(1, 1, '2006-3-21', NULL),
(2, 2, '2006-3-23', NULL),
(3, 1, '2006-3-16', NULL);

INSERT INTO `product` VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO `orderDetails` VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- Hiển thị các thông tin gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT O.`oID`, O.`oDate`, O.`oTotalPrice` FROM `order` O;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT C.`name`, P.`pName` FROM `customer` C
JOIN `order` O ON C.`cID` = O.`cID`
JOIN `orderDetails` OD ON O.`oID` = OD.`oID`
JOIN `product` P ON OD.`pID` = P.`pID`;

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT C.`name` FROM `customer` C
WHERE NOT EXISTS
(SELECT O.`cID` FROM `order` O WHERE C.`cID` = O.`cID`);

-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT O.`oID`, O.`oDate`, (OD.`odQTY` * P.`pPrice`) AS `totalPrice` FROM `orderDetails` OD
JOIN `product` P ON OD.`pID` = P.`pID`
JOIN `order` O ON OD.`oID` = O.`oID`



