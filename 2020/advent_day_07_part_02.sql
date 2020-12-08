WITH RECURSIVE t0 AS (
    SELECT container, contains, number_of
    FROM
        raw_day_07
    CROSS JOIN
        LATERAL (
            SELECT
            (string_to_array(
                regexp_replace(bag_rule, '( bags?|\.$)', '', 'g'),
                ' contain '
            ))[1] AS container,
            (string_to_array(
                regexp_replace(bag_rule, '( bags?|\.$)', '', 'g'),
                ' contain '
            ))[2] AS contained
        ) AS s0
    CROSS JOIN
        LATERAL (
            SELECT
                (regexp_match(b, '([[:digit:]]+) (.*)'))[2],
                (regexp_match(b, '([[:digit:]]+) (.*)'))[1]::int
            FROM
                (SELECT regexp_split_to_table( contained, ', ') AS "b") AS "foo"
        ) AS s1(contains, number_of)
),
t1(container, contains, bags_total) AS (
    SELECT NULL, 'shiny gold', 1
UNION ALL
    SELECT t1.contains, t0.contains, t0.number_of * t1.bags_total
    FROM
        t1
    JOIN
        t0
        ON (t1.contains = t0.container)
)
SELECT sum(bags_total) - 1 FROM t1;
