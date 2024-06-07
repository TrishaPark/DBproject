CREATE OR REPLACE PROCEDURE get_cart_items (
    p_user_id IN NUMBER,
    p_cart_items OUT SYS_REFCURSOR
) AS
BEGIN
OPEN p_cart_items FOR
SELECT cafeteria_code, menu_num, menu_name, menu_price, count
FROM cart
WHERE user_id = p_user_id;
END;