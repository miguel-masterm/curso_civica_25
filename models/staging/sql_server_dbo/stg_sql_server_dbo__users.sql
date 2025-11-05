WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),
renamed_casted AS (
    SELECT
          user_id
        , updated_at
        , address_id
        , last_name
        , created_at
        , phone_number
        , first_name
        , email
        , _fivetran_deleted AS delete_status
        , _fivetran_synced AS date_load
    FROM src_promos
    )

SELECT * FROM renamed_casted