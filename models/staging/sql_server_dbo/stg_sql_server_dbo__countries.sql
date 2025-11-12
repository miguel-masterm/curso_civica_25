WITH src_addresses AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__addresses') }}
    ),
renamed_casted AS (
    SELECT DISTINCT
        MD5(country) AS country_id
        , country
        , delete_status
        , date_load
    FROM src_addresses
    )
SELECT * FROM renamed_casted