CREATE TABLE quarterly_trends_by_ev_makers AS
(SELECT
	state,
    maker,
    vehicle_category,
    d.fiscal_year,
    d.quarter AS quarter_name,
    SUM(electric_vehicles_sold) AS total_sales,
    (SUM(electric_vehicles_sold) - LAG(SUM(electric_vehicles_sold), 1) OVER (PARTITION BY maker ORDER BY d.fiscal_year))
    / NULLIF(LAG(SUM(electric_vehicles_sold), 1) OVER (PARTITION BY maker ORDER BY d.fiscal_year), 0) * 100 AS growth_rate
FROM (SELECT
	e.date,
    s.state,
    e.maker,
    e.vehicle_category,
    e.electric_vehicles_sold
FROM
    electric_vehicle_sales_by_makers e
        JOIN
    electric_vehicle_sales_by_state s USING (date)
WHERE
    e.vehicle_category LIKE '4%') AS four_wheelers_ev_makers 
join dim_date d using (date)
WHERE d.fiscal_year in (2022,2023,2024) 
GROUP BY state, maker, d.fiscal_year, quarter_name, vehicle_category
ORDER BY maker, d.fiscal_year)
union
(SELECT
	state,
    maker,
    vehicle_category,
    d.fiscal_year,
    d.quarter AS quarter_name,
    SUM(electric_vehicles_sold) AS total_sales,
    (SUM(electric_vehicles_sold) - LAG(SUM(electric_vehicles_sold), 1) OVER (PARTITION BY maker ORDER BY d.fiscal_year))
    / NULLIF(LAG(SUM(electric_vehicles_sold), 1) OVER (PARTITION BY maker ORDER BY d.fiscal_year), 0) * 100 AS growth_rate
FROM (SELECT
	e.date,
    s.state,
    e.maker,
    e.vehicle_category,
    e.electric_vehicles_sold
FROM
    electric_vehicle_sales_by_makers e
        JOIN
    electric_vehicle_sales_by_state s USING (date)
WHERE
    e.vehicle_category LIKE '2%') AS four_wheelers_ev_makers 
join dim_date d using (date)
WHERE d.fiscal_year in (2022,2023,2024) 
GROUP BY state, maker, d.fiscal_year, quarter_name, vehicle_category
ORDER BY maker, d.fiscal_year)
