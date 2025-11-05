WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),
renamed_casted AS (
    SELECT
        MD5(promo_id) AS promo_id
        ,  promo_id AS promo_name
        , discount AS discount_dollars
        , status AS discount_status
        , _fivetran_deleted AS delete_status
        , CONVERT_TIMEZONE('TIMESTAMP_NTZ', 'UTC',_fivetran_synced) AS date_load
    FROM src_promos
    ),
new_reg AS (
    SELECT MD5('no_promo') AS promo_id,
    'no_promo' AS promo_name,
    0 AS discount_dollars,
    'inactive' AS discount_status,
    NULL AS delete_status,
    CURRENT_DATE() AS date_load
)    
SELECT * FROM renamed_casted
UNION ALL
SELECT * FROM new_reg