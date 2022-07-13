select
    parse_json(input) as parsed_input
from {{ ref('input_object_pivot') }}
