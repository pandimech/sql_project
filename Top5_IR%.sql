SELECT 
  p.product_name,
  p.category,
  SUM(((e.base_price * e.quantity_sold_after_promo) - 
       (e.base_price * e.quantity_sold_before_promo)) / 
      (e.base_price * e.quantity_sold_before_promo))  AS IR_perc
FROM retail_events_db.fact_events e
JOIN dim_products p
ON e.product_code = p.product_code
GROUP BY p.product_name, p.category
ORDER BY IR_perc DESC
LIMIT 5;