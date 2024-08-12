create table top_5_penetration_states as
(SELECT
    e.state,
    e.vehicle_category,
    sum(e.electric_vehicles_sold) as electric_vehicles_sold,
    sum(e.total_vehicles_sold) as total_vehicles_sold,
    d.fiscal_year,
    round((SUM(e.electric_vehicles_sold) / SUM(e.total_vehicles_sold)) * 100,2) AS penetration_rate
FROM
    electric_vehicle_sales_by_state e
join
	dim_date d using (date)
WHERE
    d.fiscal_year = 2024 and e.vehicle_category = "2-wheelers"
GROUP BY
    e.state, e.vehicle_category, d.fiscal_year
ORDER BY
    penetration_rate DESC
LIMIT 5)
union
(SELECT
    e.state,
    e.vehicle_category,
    sum(e.electric_vehicles_sold) as electric_vehicles_sold,
    sum(e.total_vehicles_sold) as total_vehicles_sold,
    d.fiscal_year,
    round((SUM(e.electric_vehicles_sold) / SUM(e.total_vehicles_sold)) * 100,2) AS penetration_rate
FROM
    electric_vehicle_sales_by_state e
join
	dim_date d using (date)
WHERE
    d.fiscal_year = 2024 and e.vehicle_category = "4-wheelers"
GROUP BY
    e.state, e.vehicle_category, d.fiscal_year
ORDER BY
    penetration_rate DESC
LIMIT 5)