WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),
renamed_casted AS (
    SELECT
          order_id
        , shipping_service
        , try_to_double(replace(shipping_cost, ',', '.')) AS shipping_cost
        , address_id
        , created_at
        , MD5(REPLACE(promo_id, '', 'no_promo')) AS promo_id
        , estimated_delivery_at
        , try_to_double(replace(order_cost, ',', '.')) AS order_cost
        , user_id
        , try_to_double(replace(order_total, ',', '.')) AS order_total
        , delivered_at
        , tracking_id
        , status
        , _fivetran_deleted AS delete_status
        , CONVERT_TIMEZONE('UTC',_fivetran_synced) AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted