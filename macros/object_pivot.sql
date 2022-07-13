{% macro object_pivot(t, c, primitive=true) %}
    {% set keys_query = run_query('select distinct key from ' ~ t ~ ', lateral flatten(' ~ c ~ ')' ) %}

    {% if execute %}
    {% set keys = keys_query.columns[0].values() %}
    {% else %}
    {% set keys = [] %}
    {% endif %}

    select
    {% for k in keys %}
        {% if primitive %}
            {{ dbt_variant_utils.as_primitive(t, "get(" ~ c ~ ", '" ~ k ~ "')") }} as {{ k }}
        {% else %}
            get({{ c }}, '{{ k }}') as {{ k }}
        {% endif %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
    from {{ t }}
{% endmacro %}
