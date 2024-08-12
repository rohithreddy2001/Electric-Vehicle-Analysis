create table State_Avg_unit_price as
(SELECT 
    state,
    fiscal_year,
    vehicle_category,
    SUM(electric_vehicles_sold) as ev_sales,
    SUM(electric_vehicles_sold) * 85000 as revenue
FROM
    electric_vehicle_sales_by_state s
        JOIN
    dim_date USING (date)
WHERE
    vehicle_category LIKE '2%'
group by state, fiscal_year, vehicle_category
order by state, ev_sales desc, fiscal_year)
union
(SELECT 
    state,
    fiscal_year,
    vehicle_category,
    SUM(electric_vehicles_sold) as ev_sales,
    SUM(electric_vehicles_sold) * 1500000 as revenue
FROM
    electric_vehicle_sales_by_state s
        JOIN
    dim_date USING (date)
WHERE
    vehicle_category LIKE '4%'
group by state, fiscal_year, vehicle_category
order by state, ev_sales desc, fiscal_year)
