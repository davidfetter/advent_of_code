CREATE TABLE raw_day_04(id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, pat TEXT);
\copy raw_day_04 (pat) FROM PROGRAM 'curl -b cookies.txt https://adventofcode.com/2020/day/4/input'

WITH groups AS (
    SELECT COALESCE(lag(id) over (ORDER BY id), 0) + 1 as start, id - 1 as end
    from raw_day_04
    WHERE pat = ''
),
fields AS (
    SELECT array_agg(k) AS a
    FROM
        raw_day_04 r
    JOIN
        groups g
        ON (r.id >= g.start AND r.id <= g.end),
    LATERAL (
        SELECT regexp_split_to_table(r.pat, ' ')
    ) as s0(pair),
    LATERAL (
        SELECT
            split_part(pair, ':', 1) AS k
    ) AS s1(k)
    GROUP BY g.end
)
SELECT count(*)
FROM fields
WHERE a @> ARRAY['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'];

