{{
    config(
        materialized='incremental',
        unique_key = 'ordinal_register',
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
          CAST(_row AS INT) AS ordinal_register
        , CAST(product_id AS VARCHAR) AS product_id
        , CAST(quantity AS INT) AS quantity
        , TO_DATE(month) AS month
        , CONVERT_TIMEZONE('UTC',_fivetran_synced) AS date_load
    FROM src_budget
    )

SELECT * FROM renamed_casted
