
  create or replace   view tradeflow.marts.mart_customer_summary
  
  
  
  
  as (
    SELECT
    u.id,

    count(c.id) as num_orders,
    avg(c.total) as avg_order_value,
    sum(c.discounted_total) as total_discounted_value,
    sum(c.total_products) as num_products_ordered,
    sum(c.total_quantity) as total_quantity_ordered,

    u.first_name,
    u.last_name,
    u.maiden_name,
    u.age,
    u.gender,
    u.email,
    u.phone,
    u.birth_date,
    u.address,
    u.city,
    u.state,
    u.state_code,
    u.postal_code,
    u.country,
    u.extracted_at

from tradeflow.staging.stg_users as u
left join tradeflow.staging.stg_carts as c on c.user_id = u.id

group by all
  );

