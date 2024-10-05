WITH cte AS( 
SELECT 
cam.campaign_name,
CONCAT(ROUND(SUM((e.quantity_sold_before_promo*e.base_price)/1000000),2),'M' ) AS total_revenue_before_promotion,
CONCAT(ROUND(SUM((e.quantity_sold_after_promo*e.base_price)/1000000),2),'M') AS total_revenue_after_promotion
FROM retail_events_db.fact_events e
JOIN retail_events_db.dim_campaigns cam
ON e.campaign_id=cam.campaign_id
GROUP BY cam.campaign_name)


SELECT 
campaign_name,
total_revenue_before_promotion,
total_revenue_after_promotion,
ROUND(((total_revenue_after_promotion-total_revenue_before_promotion)
/total_revenue_before_promotion)*100,2) AS per_growth
FROM cte