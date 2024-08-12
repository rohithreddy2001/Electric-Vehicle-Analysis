create table penetration_yoy_change as 
SELECT 
    e.state,
    e.vehicle_category,
    SUM(e.electric_vehicles_sold) AS electric_vehicles_sold,
    SUM(e.total_vehicles_sold) AS total_vehicles_sold,
    d.fiscal_year,
    ROUND((SUM(e.electric_vehicles_sold) / SUM(e.total_vehicles_sold)) * 100, 2) AS penetration_rate,
    ROUND(((ROUND((SUM(e.electric_vehicles_sold) / SUM(e.total_vehicles_sold)) * 100, 2)) 
            - LAG(ROUND((SUM(e.electric_vehicles_sold) / SUM(e.total_vehicles_sold)) * 100, 2)) 
            OVER (PARTITION BY e.state, e.vehicle_category ORDER BY d.fiscal_year)), 2) 
        AS penetration_change_yoy
FROM
    electric_vehicle_sales_by_state e
        JOIN
    dim_date d USING (date)
GROUP BY e.state, e.vehicle_category, d.fiscal_year
ORDER BY e.state, e.vehicle_category, d.fiscal_year;
