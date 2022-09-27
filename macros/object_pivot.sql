{%- macro object_pivot(t, c, primitive=true, include_columns=[], exclude_keys=['null']) -%}
    {%- set query = "select distinct key, regexp_replace(key, '[ .]', '_') as alias_key from " ~ t ~ ", lateral flatten(" ~ c ~ ")" -%}
    {%- set keys_query = run_query(query) -%}
    
    {%- if execute -%}
    {%- set keys = keys_query.columns[0].values() -%}
    {%- set alias_keys = keys_query.columns[1].values() -%}
    {%- else -%}
    {%- set keys = [] -%}
    {%- set alias_keys = [] -%}
    {%- endif -%}

    select
    {%- for ic in include_columns %}
        {{ ic }},
    {%- endfor -%}
    {%- for k in keys -%}
    {%- set alias_key = alias_keys[loop.index0] -%}
        {%- if k not in exclude_keys -%}
            {%- if primitive -%}
                {{ dbt_variant_utils.as_primitive(t, "get(" ~ c ~ ", '" ~ k ~ "')") }} as {{ alias_key }}
            {%- else -%}
                get({{ c }}, '{{ k }}') as {{ alias_key }}
            {%- endif -%}
            {%- if not loop.last -%},{%- endif -%}
        {%- endif -%}
    {%- endfor %}
    from {{ t }}
{% endmacro %}
