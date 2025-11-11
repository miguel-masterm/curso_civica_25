WITH src_addresses AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__addresses') }}
    ),
renamed_casted AS (
    SELECT DISTINCT
        MD5(state) AS state_id
        , state
        , MD5(country) AS country_id
        , delete_status
        , date_load
    FROM src_addresses
    )
SELECT * FROM renamed_casted