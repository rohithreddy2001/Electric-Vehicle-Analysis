create table Avg_unit_price as
(SELECT 
    maker,
    fiscal_year,
    vehicle_category,
    SUM(electric_vehicles_sold) as ev_sales,
    SUM(electric_vehicles_sold) * 85000 as revenue
FROM
    electric_vehicle_sales_by_makers m
        JOIN
    dim_date USING (date)
WHERE
    vehicle_category LIKE '2%'
group by maker, fiscal_year, vehicle_category
order by maker, ev_sales desc, fiscal_year)
union
(SELECT 
    maker,
    fiscal_year,
    vehicle_category,
    SUM(electric_vehicles_sold) as ev_sales,
    SUM(electric_vehicles_sold) * 1500000 as revenue
FROM
    electric_vehicle_sales_by_makers m
        JOIN
    dim_date USING (date)
WHERE
    vehicle_category LIKE '4%'
group by maker, fiscal_year, vehicle_category
order by maker, ev_sales desc, fiscal_year)
