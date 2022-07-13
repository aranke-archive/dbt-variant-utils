# dbt-variant-utils

Various [dbt](https://www.getdbt.com/) utilities for working with semi-structured `variant` data in Snowflake (including `object`s and `array`s).

## Macros

### as_primitive ([source](macros/as_primitive.sql))

Converts a `variant` to a primitive type using Snowflake's built-in [`typeof`](https://docs.snowflake.com/en/sql-reference/functions/typeof.html) function.
Returns `null` if the value cannot be cast to a primitive type.

Usage:

```sql
select
    {{ dbt_variant_utils.as_primitive(ref('table'), 'column') }} as primitive_column
from {{ ref('table') }}
```

### object_pivot ([source](macros/object_pivot.sql))

Pivots a column of `object` types into a table with each column representing a key and each row representing a value.
If a key is missing from the input, its value will be `null` in the output table.

```sql
with pivot_table as (
    {{ dbt_variant_utils.object_pivot(ref('table'), 'column') }}
)

select * from pivot_table
```
