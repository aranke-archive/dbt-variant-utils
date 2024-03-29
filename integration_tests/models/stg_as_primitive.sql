select
    1::variant as same_type,
    'foo'::variant as with_null,
    true::variant as different_types,
    0.567453454::variant as decimal_number
union all
select
    2::variant as same_type,
    null::variant as with_null,
    4::variant as different_types,
    1.05::variant as decimal_number
union all
select
    3::variant as same_type,
    'bar'::variant as with_null,
    false::variant as different_types,
    0.4532::variant as decimal_number
