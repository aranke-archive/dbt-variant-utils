{%- macro as_primitive(t, c) -%}
    {% set query = "
        select 
            typeof(" ~ c ~ ") as type, 
            ifnull(len(split(" ~ c ~ ", '.')[1]), 2) as precision 
        from " ~ t ~ " 
        where type is not null 
        limit 1" %}
    {%- set type_query = run_query(query) -%}

    {%- if execute -%}
    {%- set type = type_query.columns[0][0] -%}
    {%- set precision = type_query.columns[1][0] -%}
    {%- else -%}
    {%- set type = none -%}
    {%- set precision = none -%}
    {%- endif -%}

    {%- if type and type|lower not in ['null_value'] -%}
        {%- if type|lower == 'decimal' %}
            as_{{ type|lower }}({{ c }}, 38, {{ precision }})
        {%- else %}
            as_{{ type|lower }}({{ c }})
        {%- endif -%}
    {%- else %}
        null
    {%- endif -%}
{% endmacro %}
