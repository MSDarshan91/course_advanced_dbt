{% test assert_valid_event_name(model, column_name) %}
/* Checks whether the target column contains word 'test'*/
SELECT *
FROM {{ model }}
WHERE lower({{ column_name }}) LIKE '%test%'

{% endtest %}
