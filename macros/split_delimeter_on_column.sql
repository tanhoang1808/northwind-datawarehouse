{% macro split_by_delimiter(column, delimiter) %}
    LATERAL FLATTEN(input => SPLIT({{ column }}, '{{ delimiter }}'))
{% endmacro %}
