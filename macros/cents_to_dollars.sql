{# A basic example for a project-wide macro to cast a column uniformly #}

{% macro cents_to_dollars(column_name) -%}
    {{ return(adapter.dispatch('cents_to_dollars')(column_name)) }}
{%- endmacro %}

{# you can also specify a default__ instead of snowflake #}

{% macro snowflake__cents_to_dollars(column_name) -%}
    ({{ column_name }} / 100)::numeric(16, 2)
{%- endmacro %}

