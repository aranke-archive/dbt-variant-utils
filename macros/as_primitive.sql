{% macro as_primitive(t, c) %}
    {% set type_query = run_query('select typeof(' ~ c ~ ') as type, count(*) from ' ~ t ~ ' where type is not null group by 1 order by 2 desc limit 1') %}

    {% if execute %}
    {% set type = type_query.columns[0][0] %}
    {% else %}
    {% set type = none %}
    {% endif %}

    {% if type %}
        as_{{ type|lower }}({{ c }})
    {% else %}
        null
    {% endif %}
{% endmacro %}
