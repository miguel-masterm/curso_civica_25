WITH src_addresses AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__addresses') }}
    ),
renamed_casted AS (
    SELECT
        address_id
        , address
        , MD5(zipcode) AS zipcode_id
        , delete_status
        , date_load
    FROM src_addresses
    )
SELECT * FROM renamed_casted