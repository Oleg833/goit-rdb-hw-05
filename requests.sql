SELECT 
    od.*,
    (SELECT o.customer_id FROM orders o WHERE o.id = od.order_id) AS customer_id
FROM 
    order_details od;


SELECT 
    od.*
FROM 
    order_details od
WHERE 
    od.order_id IN (SELECT o.id FROM orders o WHERE o.shipper_id = 3);


SELECT 
    sub.order_id,
    AVG(sub.quantity) AS average_quantity
FROM 
    (SELECT * FROM order_details WHERE quantity > 10) AS sub
GROUP BY 
    sub.order_id;


WITH temp AS (
    SELECT * 
    FROM order_details 
    WHERE quantity > 10
)
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS average_quantity
FROM 
    temp
GROUP BY 
    temp.order_id;


DROP FUNCTION IF EXISTS divide_floats;

DELIMITER //

CREATE FUNCTION divide_floats(a FLOAT, b FLOAT) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN a / b;
END //

DELIMITER ;

SELECT 
    id,
    order_id,
    product_id,
    quantity,
    divide_floats(quantity, 2.5) AS divided_quantity
FROM 
    order_details;
