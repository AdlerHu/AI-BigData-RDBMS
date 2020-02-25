INSERT INTO food VALUES ('CK001', '曲奇餅乾', '2018/01/10', 'TL', 250, '點心');
INSERT INTO food VALUES ('CK002', '蘇打餅乾', '2017/10/12', 'TW', 80, '點心');
INSERT INTO food VALUES ('DK001', '高山茶', '2018/05/23', 'TW', 780, '飲料');
INSERT INTO food VALUES ('DK002', '綠茶', '2017/06/11', 'JP', 530, '飲料');
INSERT INTO food VALUES ('OL001', '苦茶油', '2019/03/16', 'TW', 360, '調味品');
INSERT INTO food VALUES ('OL002', '橄欖油', '2018/07/25', 'TL', 420, '調味品');
INSERT INTO food VALUES ('CK003', '仙貝', '2017/11/01', 'JP', 270, '點心');
INSERT INTO food VALUES ('SG001', '醬油', '2019/05/05', 'JP', 260, '調味品');
INSERT INTO food VALUES ('OL003', '葡萄子油', '2019/05/05', 'JP', 550, '調味品');
INSERT INTO food VALUES ('CK004', '鳳梨酥', '2017/10/12', 'TW', 340, '點心');
INSERT INTO food VALUES ('CK005', '太陽餅', '2017/08/27', 'TW', 150, '點心');
INSERT INTO food VALUES ('DK003', '紅茶', '2019/11/12', 'TL', 260, '飲料');
INSERT INTO food VALUES ('SG002', '醋', '2018/09/18', 'TW', 60, '調味品');

INSERT INTO place VALUES ('TW', '台灣');
INSERT INTO place VALUES ('JP', '日本');
INSERT INTO place VALUES ('TL', '泰國');
INSERT INTO place VALUES ('US', '美國');

SET SQL_SAFE_UPDATES = 0; 
UPDATE food SET expiredate = ADDDATE(expiredate, INTERVAL 2 YEAR) ;

SELECT * FROM food;
SELECT name, expiredate, price FROM food;
SELECT 
	name AS '名稱',
	expiredate AS '到期日',
	price AS '價格'
    FROM food;
SELECT DISTINCT catalog FROM food;
SELECT 
	name,
    catalog,
    CONCAT(name, ' ' , catalog)
FROM food;

SELECT name,price FROM food WHERE price >=400 ;
SELECT name,price FROM food WHERE price BETWEEN 250 AND 530 ;
SELECT name,price FROM food WHERE price NOT BETWEEN 250 AND 530 ;
SELECT name,price FROM food WHERE catalog = '點心' ;
SELECT name,price,catalog FROM food WHERE catalog = '點心' OR catalog = '飲料' ;
SELECT name,price FROM food WHERE placeid = 'TW' OR placeid = 'JP' ;
SELECT name, expiredate, price FROM food WHERE name LIKE '%油%';
SELECT name,price FROM food WHERE expiredate < '2020-12-31' ;
SELECT name,price FROM food WHERE expiredate < '2021-06-30' ;
SELECT name,price FROM food WHERE expiredate < SYSDATE() + INTERVAL 6 MONTH ;

SELECT name, expiredate, price FROM food ORDER BY price DESC;

-- 17.	查詢前三個價格最高的食物名稱、到期日和價格，並以價格做降冪排序
SELECT name, expiredate, price FROM food ORDER BY price DESC LIMIT 3;

-- 18.	查詢種類為'點心'且價格低於等於250的食物名稱和價格，並以價格做升冪排序
SELECT name, price FROM food WHERE catalog = '點心' AND price < 250 ORDER BY price;

-- 19.	顯示所有食物名稱、價格和增加5%且四捨五入為整數後的價格，新價格並將表頭命名為'New Price'
SELECT 
	name, 
	price,
    ROUND(price*1.05) AS 'New Price'
    FROM food;
    
-- 20.	接續上題，再增加一個表頭命名為'Increase'，顯示New price減去price的值
SELECT
	name,
    price,
	ROUND(price*1.05) AS 'New Price',
	(ROUND(price*1.05) - price) AS 'Increase'
    FROM food;
    
-- 21.	顯示所有食物名稱、價格和整數後的價格，新價格並將表頭命名為'New Price'；按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
SELECT name, price,  
	CASE
		WHEN price < 250 THEN ROUND(price*1.08)
		WHEN price BETWEEN 250 AND 500 THEN ROUND(price*1.05)
        WHEN price > 500 THEN ROUND(price*1.03)
	END 'New Price'
FROM food;

-- 22.	查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
SELECT	f.name,
		f.catalog,
        DATEDIFF(f.expiredate, NOW()) AS 'WTF',
		
        IF(DATEDIFF(f.expiredate, NOW()) <0,'已過期','') 'Days of expired',
        IF(DATEDIFF(f.expiredate, NOW()) >=0,'未過期','') 'Expired or not'     
FROM food f;

-- 23.	接續上題，並以過期天數做升冪排序
SELECT	f.name,
		f.catalog,
        DATEDIFF(f.expiredate, NOW()) AS 'WTF',
		
        IF(DATEDIFF(f.expiredate, NOW()) <0,'已過期','') 'Days of expired',
        IF(DATEDIFF(f.expiredate, NOW()) >=0,'未過期','') 'Expired or not'     
FROM food f
ORDER BY WTF;

-- --- GROUP BY & HAVING子句
-- 24.	查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT
	MAX(price) AS 'Max', 
	MIN(price) AS 'Min', 
    SUM(price) AS 'Sum', 
    ROUND(AVG(price)) AS 'Avg'
FROM food;

-- 25.	接續上題，查詢每個種類
SELECT
	catalog,
	MAX(price) AS 'Max', 
	MIN(price) AS 'Min', 
    SUM(price) AS 'Sum', 
    ROUND(AVG(price)) AS 'Avg'
FROM food
GROUP BY catalog;

-- 26.	接續上題，查詢每個種類且平均價格超過300，並以平均價格做降冪排序
SELECT
	catalog,
	MAX(price) AS 'Max', 
	MIN(price) AS 'Min', 
    SUM(price) AS 'Sum', 
    ROUND(AVG(price)) AS 'Avg'
FROM food
GROUP BY catalog
HAVING ROUND(AVG(price)) >300
ORDER BY ROUND(AVG(price)) DESC;

-- 27.	顯示查詢每個種類的食物數量
SELECT
	catalog,
	COUNT(name)
FROM food
GROUP BY catalog;

-- 28.	查詢不同產地和每個種類的食物數量
SELECT
	placeid,
	catalog,
	COUNT(name)
FROM food
GROUP BY placeid, catalog;

-- 1.	查詢所有食物名稱、產地編號、產地名稱和價格
SELECT 	f.name, f.placeid, p.name, f.price
FROM 	food f, place p
WHERE 	f.placeid = p.id;

-- 2.	查詢所有食物名稱和產地名稱，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & place'
SELECT 	CONCAT(f.name, " ", p.name) AS 'Food name & place'
FROM 	food f, place p
WHERE 	f.placeid = p.id;

-- 3.	查詢所有'台灣'生產的食物名稱和價格
SELECT 	f.name, f.price
FROM 	food f, place p
WHERE 	f.placeid = p.id
AND		p.name = '台灣';

-- 4.	查詢所有'台灣'和'日本'生產的食物名稱和價格，並以價格做降冪排序
SELECT 	f.name, f.price
FROM 	food f, place p
WHERE 	f.placeid = p.id
AND		p.name = '台灣' OR p.name = '日本'
ORDER BY f.price DESC;

-- 5.	查詢前三個價格最高且'台灣'生產的食物名稱、到期日和價格，並以價格做降冪排序
SELECT 	f.name, f.expiredate, f.price
FROM 	food f, place p
WHERE 	f.placeid = p.id
AND		p.name = '台灣'
ORDER BY f.price DESC
LIMIT 	3;

-- 6.	查詢每個產地(顯示產地名稱)最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT 	p.name,
		MAX(f.price) 		AS 'Max',
		MIN(f.price) 		AS 'Min',
		SUM(f.price) 		AS 'Sum',
		ROUND(AVG(f.price))	AS	'Avg'
        
FROM 	food f, place p
WHERE 	f.placeid = p.id
GROUP BY p.name;

-- 7.	查詢不同產地(顯示產地名稱)和每個種類的食物數量
SELECT 	p.name,
		f.catalog,
		COUNT(f.name)
        
FROM 	food f, place p
WHERE 	f.placeid = p.id
GROUP BY p.name, f.catalog;





