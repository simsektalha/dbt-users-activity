-- Daily aggregated metrics by event_date, country, and platform
-- This model provides key business metrics for reporting and analysis

with daily_activity as (
    select
        event_date,
        coalesce(cast(country as string), 'Unknown') as country,  -- Handle empty country values
        upper(platform) as platform,  -- Standardize platform to uppercase
        count(distinct user_id) as dau,
        sum(iap_revenue) as total_iap_revenue,
        sum(ad_revenue) as total_ad_revenue,
        sum(match_start_count) as matches_started,
        sum(match_end_count) as matches_ended,
        sum(victory_count) as total_victories,
        sum(defeat_count) as total_defeats,
        sum(server_connection_error) as total_server_errors
    from {{ source('raw_data', 'user_activity') }}
    group by event_date, coalesce(cast(country as string), 'Unknown'), upper(platform)
)

select
    event_date,
    country,
    platform,
    dau,
    total_iap_revenue,
    total_ad_revenue,
    -- Calculate ARPDAU (Average Revenue Per Daily Active User)
    case 
        when dau > 0 then (total_iap_revenue + total_ad_revenue) / dau
        else 0
    end as arpdau,
    matches_started,
    -- Calculate average matches per DAU
    case 
        when dau > 0 then cast(matches_started as float64) / dau
        else 0
    end as match_per_dau,
    -- Calculate win ratio
    case 
        when matches_ended > 0 then cast(total_victories as float64) / matches_ended
        else 0
    end as win_ratio,
    -- Calculate defeat ratio
    case 
        when matches_ended > 0 then cast(total_defeats as float64) / matches_ended
        else 0
    end as defeat_ratio,
    -- Calculate server errors per DAU
    case 
        when dau > 0 then cast(total_server_errors as float64) / dau
        else 0
    end as server_error_per_dau
from daily_activity
order by event_date desc, country, platform
