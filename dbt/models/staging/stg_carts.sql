select

    raw_data:id::INT as id,
    raw_data:userId::INT user_id,
    raw_data:products as products,
    raw_data:total::FLOAT  total,
    raw_data:discountedTotal::FLOAT  as discounted_total,
    raw_data:totalProducts::INT as total_products,
    raw_data:totalQuantity::INT as total_quantity,
    extracted_at

from {{ source ('tradeflow_raw', 'raw_carts')}}