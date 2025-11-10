WITH src_addresses AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__addresses') }}
    ),
unique_data AS (
    SELECT DISTINCT
        country
        , state
        , zipcode
        , delete_status
        , date_load
    FROM src_addresses
    )
SELECT * FROM renamed_casted