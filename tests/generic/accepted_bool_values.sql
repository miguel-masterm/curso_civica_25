{% test accepted_bool_values(model, column_name) %}

    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} NOT IN (TRUE, FALSE)
    AND {{ column_name }} IS NOT NULL

{% endtest %}
