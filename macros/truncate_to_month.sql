{% macro truncate_to_month(date) %}
    date(date_trunc('month', {{ date }} ))
{% endmacro %}
