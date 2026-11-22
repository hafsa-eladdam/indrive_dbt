-- grain: une ligne = un chauffeur pour un jour donné
with daily as (
    select
        driver_id,
        cast(requested_at as date) as ride_date,
        count(*) as nb_rides,
        sum(fare_amount) as daily_earnings
    from {{ ref('fact_rides') }}
    group by 1, 2
)

select
    driver_id,
    ride_date,
    nb_rides,
    daily_earnings,
    sum(daily_earnings) over (
        partition by driver_id
        order by ride_date
        rows between unbounded preceding and current row
    ) as cumulative_earnings,
    rank() over (
        partition by ride_date
        order by daily_earnings desc
    ) as daily_rank
from daily