
  create or replace   view tradeflow.intermediate.int_cart_products
  
  
  
  
  as (
    select
    c.raw_data:id::INT as cart_id,
    p.value:id::INT as product_id,
    p.value:title::VARCHAR title,
    p.value:quantity::FLOAT quantity,
    p.value:total::FLOAT total,
    p.value:discountPercentage::FLOAT discount_percentage,
    p.value:discountedTotal::FLOAT discounted_total

from tradeflow.raw.raw_carts c,
lateral flatten(input => c.raw_data:products) p
  );

