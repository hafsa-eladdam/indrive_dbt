select
    driver_id,
    driver_name,
    phone,
    city,
    rating,
    joined_date
from {{ source('raw', 'raw_drivers') }}