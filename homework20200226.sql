-- 1.	查詢所有比'鳳梨酥'貴的食物名稱、到期日和價格
SELECT	f.name, f.expiredate, f.price
FROM food f
WHERE f.price > (	SELECT	price
					FROM	food
					WHERE	name = '鳳梨酥');

-- 2.	查詢所有比'曲奇餅乾'便宜且種類是'點心'的食物名稱、到期日和價格
SELECT	f.name, f.expiredate, f.price, f.catalog
FROM food f
WHERE f.price < (	SELECT	price
					FROM	food
					WHERE	name = '曲奇餅乾')
AND f.catalog = '點心';

-- 3.	查詢所有和'鳳梨酥'同一年到期的食物名稱、到期日和價格
SELECT	f.name, f.expiredate, f.price
FROM food f
WHERE YEAR(f.expiredate) = (	SELECT	YEAR(expiredate)
								FROM	food
								WHERE	name = '鳳梨酥');

-- 4.	查詢所有比平均價格高的食物名稱、到期日和價格
SELECT f.name, f.expiredate, f.price
FROM food f
WHERE f.price >  (	SELECT	AVG(price)
					FROM	food);

-- 5.	查詢所有比平均價格低的'台灣'食物名稱、到期日和價格
SELECT f.name, f.expiredate, f.price
FROM food f
WHERE f.price <  (	SELECT	AVG(price)
					FROM	food)
AND f.placeid = 'TW';


-- 6.	查詢所有種類和'仙貝'相同且價格比'仙貝'便宜的食物名稱、到期日和價格
SELECT f.name, f.expiredate, f.price
FROM food f
WHERE f.catalog = ( SELECT 	catalog
					FROM	food
					WHERE	name = '仙貝')
AND	f.price < (	SELECT 	price
				FROM	food
				WHERE	name = '仙貝');
                
-- 7.	查詢所有產地和'仙貝'相同且過期超過6個月以上的食物名稱、到期日和價格
SELECT 	f.name, f.expiredate, f.price
FROM	food f
WHERE	f.placeid = (	SELECT	placeid
						FROM	food
						WHERE	name = '仙貝')
AND		DATEDIFF(f.expiredate,NOW()) <-180;

-- select 	f.name, f.expiredate, datediff(f.expiredate,now())
-- from	food f;


-- 8.	查詢每個產地價格最低的食物名稱、到期日和價格
SELECT	f.name, f.expiredate, f.price
FROM	food f
WHERE	price = (	SELECT	MIN(price)
					FROM	food
					WHERE	placeid = f.placeid);
                    
-- 9.	查詢每個種類的食物價格最高者的食物名稱和價格
SELECT	f.name, f.price, f.catalog
FROM	food f
WHERE	price = (	SELECT	MAX(price)
					FROM	food
					WHERE	catalog = f.catalog);

-- 10.	查詢所有種類不是'點心'但比種類是'點心'貴的食物名稱、種類和價格，並以價格做降冪排序
# < max
SELECT	f.name, f.catalog, f.price
FROM	food f
WHERE	price > (	SELECT	MAX(price)
					FROM	food
					WHERE	catalog = '點心')
AND f.catalog != '點心'
ORDER BY f.price DESC;

-- 11.	查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
SELECT	f.name, f.price, p.name
FROM	food f JOIN place p
ON	price = (	SELECT	MAX(price)
				FROM	food
				WHERE	placeid = f.placeid)
AND		f.placeid = p.id;


-- 1.	以不列舉欄位的方式新增一筆食物資料
INSERT INTO food
VALUES ('SG003', '邁泰', '2020-03-05', 'TW', 300, '飲料');

-- 2.	以列舉欄位的方式新增一筆食物資料
INSERT INTO food (id, name, expiredate, placeid, price, catalog)
VALUES ('SG004', '自由古巴', '2020-02-06', 'TW', 150, '飲料');

-- 3.	以不列舉欄位的方式新增多產地資料
INSERT INTO place
VALUES ('DE', '德國'), ('MX', '墨西哥');

-- 4.	修改一筆食物資料的價格
UPDATE 	food f
SET		price = 180
WHERE	f.name = '自由古巴';

-- 5.	按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
SELECT name, price,  
	CASE
		WHEN price < 250 THEN ROUND(price*1.08)
		WHEN price BETWEEN 250 AND 500 THEN ROUND(price*1.05)
        WHEN price > 500 THEN ROUND(price*1.03)
	END 'New Price'
FROM food;

-- 6.	刪除一筆食物資料
DELETE FROM food WHERE name = '自由古巴';


