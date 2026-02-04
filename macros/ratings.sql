{% macro get_column_values(table_name, column_name) %}
   {%- set query -%}
    select distinct {{column_name}}
    from {{ ref(table_name)}}
   {%- endset -%}
   {%- if execute -%}
   {%- set results = run_query(query) -%}
   {%- set result_list = results.columns[0].values() -%}
   {%- else -%}
   {%- set result_list = [] -%}
   {%- endif -%}
   {{ return(result_list)}}
{% endmacro %}


{% macro get_elems_count(table_name, column_name) %}
    {% set elems = get_column_values (table_name, column_name) %}
    {%- for el in elems -%}
    SUM(
        CASE WHEN {{column_name}} = '{{el}}' THEN 1 ELSE 0 END
    ) as num_{{el | lower()}}
    {%- if not loop.last -%} , {%- endif -%}
    {%- endfor -%}
{% endmacro %}