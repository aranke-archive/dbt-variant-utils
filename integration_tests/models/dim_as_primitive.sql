select
    {{ dbt_variant_utils.as_primitive(ref('stg_as_primitive'), 'same_type') }} as cast_same_type,
    {{ dbt_variant_utils.as_primitive(ref('stg_as_primitive'), 'with_null') }} as cast_with_null,
    {{ dbt_variant_utils.as_primitive(ref('stg_as_primitive'), 'different_types') }} as cast_different_types,
    {{ dbt_variant_utils.as_primitive(ref('stg_as_primitive'), 'decimal_number') }} as cast_decimal_number
from {{ ref('stg_as_primitive') }}
