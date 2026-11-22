with rides as (
    select * from {{ ref('stg_ride_events') }}
),

current_drivers as (
    select * from {{ ref('drivers_snapshot') }}
    where dbt_valid_to is null
),

vehicles as (
    select * from {{ ref('stg_vehicles') }}
)

select
    r.ride_id,
    r.driver_id,
    r.pickup_zone_id,
    r.dropoff_zone_id,
    r.distance_km,
    r.fare_amount,
    r.requested_at,
    d.rating as driver_rating,
    {{ rating_bucket('d.rating') }} as driver_rating_bucket,
    v.vehicle_id
from rides r
left join current_drivers d on d.driver_id = r.driver_id
left join vehicles v on v.driver_id = r.driver_id