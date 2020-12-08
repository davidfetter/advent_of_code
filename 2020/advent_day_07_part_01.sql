CREATE TABLE IF NOT EXISTS raw_day_07(id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, bag_rule TEXT);
\copy raw_day_07 (bag_rule) FROM PROGRAM 'curl -b cookies.txt https://adventofcode.com/2020/day/7/input'

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
t1 AS (
    SELECT container, contains
    FROM t0
    WHERE t0.contains = 'shiny gold'
UNION ALL
    SELECT
        t0.container, t0.contains
    FROM
        t0
    JOIN
        t1
        ON t0.contains = t1.container
)
SELECT count(distinct container)
FROM t1;
