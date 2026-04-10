SELECT
    raw_data:id::INT as id,
    raw_data:firstName::VARCHAR as first_name,
    raw_data:lastName::VARCHAR as last_name,
    raw_data:maidenName::VARCHAR as maiden_name,
    raw_data:age::INT as age,
    raw_data:gender::VARCHAR as gender,
    raw_data:email::VARCHAR as email,
    raw_data:phone::VARCHAR as phone,
    raw_data:birthDate::VARCHAR as birth_date,
    raw_data:address:address::VARCHAR as address,
    raw_data:city:address::VARCHAR as city,
    raw_data:state:address::VARCHAR as state,
    raw_data:stateCode:address::VARCHAR as state_code,
    raw_data:postalCode:address::VARCHAR as postal_code,
    raw_data:country:address::VARCHAR as country,
    extracted_at

from tradeflow.raw.raw_users