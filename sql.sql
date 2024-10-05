SELECT * 
FROM
fact_events f
JOIN dim_products p
ON f.product_code=p.product_code
WHERE base_price>500 AND promo_type='BOGOF';