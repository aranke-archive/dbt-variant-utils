{%- macro object_pivot(t, c, primitive=true, include_columns=[], exclude_keys=['null']) -%}
    {%- set query = "select distinct regexp_replace(key, '[ .]', '_') from " ~ t ~ ", lateral flatten(" ~ c ~ ")" -%}
    {%- set keys_query = run_query(query) -%}
    
    {%- if execute -%}
    {%- set keys = keys_query.columns[0].values() -%}
    {%- else -%}
    {%- set keys = [] -%}
    {%- endif -%}

    select
    {%- for ic in include_columns %}
        {{ ic }},
    {%- endfor -%}
    {%- for k in keys -%}
        {%- if k not in exclude_keys -%}
            {%- if primitive -%}
                {{ dbt_variant_utils.as_primitive(t, "get(" ~ c ~ ", '" ~ k ~ "')") }} as {{ k }}
            {%- else -%}
                get({{ c }}, '{{ k }}') as {{ k }}
            {%- endif -%}
            {%- if not loop.last -%},{%- endif -%}
        {%- endif -%}
    {%- endfor %}
    from {{ t }}
{% endmacro %}
