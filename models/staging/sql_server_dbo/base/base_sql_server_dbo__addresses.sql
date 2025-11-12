WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),
renamed_casted AS (
    SELECT
          CAST(address_id AS VARCHAR) AS address_id
        , CAST(address AS VARCHAR) AS address
        , CAST(country AS VARCHAR) AS country
        , CAST(state AS VARCHAR) AS state
        , CAST(zipcode AS INT) AS zipcode
        , COALESCE(CAST(_fivetran_deleted AS BOOLEAN), FALSE) AS delete_status
        , CONVERT_TIMEZONE('UTC', _fivetran_synced) AS date_load
    FROM src_addresses
    )
SELECT * FROM renamed_casted