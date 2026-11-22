select
    ride_id,
    driver_id,
    pickup_zone_id,
    dropoff_zone_id,
    distance_km,
    fare_amount,
    requested_at
from {{ source('raw', 'raw_ride_events') }}
where requested_at >= '{{ var('start_date') }}'