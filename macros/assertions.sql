-- simple macro to assert row counts
{% macro assert_min_rows(model, min_rows=1) %}
select count(*) as row_count from {{ model }}
where (select count(*) from {{ model }}) >= {{ min_rows }}
{% endmacro %}