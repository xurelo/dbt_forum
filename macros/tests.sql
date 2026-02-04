{% test value_greater_than (model, column_name, threshold) %}
SELECT * FROM {{model}} WHERE {{column_name}} > {{threshold}}
{% endtest %}