select

    sum(cp.quantity) demand,
    p.stock as product_in_stock,
    case 
        when p.stock < p.minimum_order_quantity then 'critical'
        when p.stock < p.minimum_order_quantity * 2 then 'low'
        else 'healthy'
    end as stock_status,

    p.id as product_id,
    p.title as title,
    p.category as category,
    p.price as price,
    p.discount_percentage as product_discount_percentage,
    p.rating as product_rating,
    p.brand as product_brand,
    p.sku as product_sku,
    p.weight as product_weight,
    p.width as product_width,
    p.height as product_height,
    p.depth as product_depth,
    p.warranty_info as product_warranty_info,
    p.shipping_info as product_shipping_info,
    p.availability_status as product_availability_status,
    p.return_policy as product_return_policy,
    p.minimum_order_quantity as product_minimum_order_quantity,
    p.created_at as product_created_at,
    p.updated_at as product_updated_at,
    p.extracted_at
    
from tradeflow.staging.stg_products as p
left join tradeflow.intermediate.int_cart_products as cp on cp.product_id = p.id

group by all