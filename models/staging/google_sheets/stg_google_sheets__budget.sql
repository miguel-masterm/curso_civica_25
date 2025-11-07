{{
    config(
        materialized='incremental',
        unique_key = '_row',
        on_schema_change='fail'
    )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}

    {% if is_incremental() %}

    where _fivetran_synced > (select max(date_load) from {{ this }})

    {% endif %}
    ),
renamed_casted AS (
    SELECT
          _row
        , product_id
        , quantity
        , month
        , _fivetran_synced AS date_load
    FROM src_budget
    )

SELECT * FROM renamed_casted
