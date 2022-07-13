{{ dbt_variant_utils.object_pivot(
    ref('stg_object_pivot'),
    'parsed_input',
    exclude_keys=['excluded_key'],
    include_columns=['idx']
) }}
