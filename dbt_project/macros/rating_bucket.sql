{% macro rating_bucket(rating_col) -%}
    case
        when {{ rating_col }} is null then 'unknown'
        when {{ rating_col }} < 4.5 then 'below 4.5'
        when {{ rating_col }} <= 4.8 then '4.5-4.8'
        else 'above 4.8'
    end
{%- endmacro %}