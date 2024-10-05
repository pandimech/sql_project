WITH cte AS 
(SELECT 
p.category,
SUM(e.quantity_sold_after_promo) AS q_s_a_p,
SUM(e.quantity_sold_before_promo) AS q_s_b_p
FROM retail_events_db.fact_events e
JOIN dim_products p
ON e.product_code=p.product_code
WHERE campaign_id='CAMP_DIW_01'
GROUP BY category),
cte1 AS
(SELECT 

category,
q_s_a_p,
q_s_b_p,
ROUND((q_s_a_p-q_s_b_p)/q_s_b_p*100 ,2) AS ISU_per
FROM cte )

SELECT *,
DENSE_RANK () OVER(ORDER BY ISU_Per DESC) AS rank_ISU

 FROM 
cte1
