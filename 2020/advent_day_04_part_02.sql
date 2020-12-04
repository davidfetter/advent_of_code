WITH groups AS (
    SELECT COALESCE(lag(id) over (ORDER BY id), 0) + 1 as start, id - 1 as end
    from raw_day_04
    WHERE pat = ''
),
fields AS (
    SELECT jsonb_object_agg(k, v) AS o
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
            split_part(pair, ':', 1) AS k,
            split_part(pair, ':', 2) AS v
    ) AS s1(k, v)
    GROUP BY g.end
    HAVING
        jsonb_object_agg(k,v)->>'byr' ~ '^[[:digit:]]{4}$' AND
        jsonb_object_agg(k,v)->>'iyr' ~ '^[[:digit:]]{4}$' AND
        jsonb_object_agg(k,v)->>'eyr' ~ '^[[:digit:]]{4}$' AND
        jsonb_object_agg(k,v)->>'hgt' ~ '^([[:digit:]]{3}cm|[[:digit:]]{2}in)' AND
        jsonb_object_agg(k,v)->>'hcl' ~ '^#[0-9a-f]{6}$' AND
        jsonb_object_agg(k,v)->>'ecl' = ANY(string_to_array('amb blu brn gry grn hzl oth', ' ')) AND
        jsonb_object_agg(k,v)->>'pid' ~ '^[[:digit:]]{9}$'
)
SELECT count(*)
FROM fields
WHERE
        (o->>'byr')::int <@ int4range(1920, 2002, '[]') AND
        (o->>'iyr')::int <@  int4range(2010, 2020, '[]') AND
        (o->>'eyr')::int <@  int4range(2020, 2030, '[]') AND
        (
            (
                length(o->>'hgt') = 5 AND
                substring(o->>'hgt', 1,3)::int <@ int4range(150, 193, '[]') AND
                substring(o->>'hgt', 4,2) = 'cm'
            ) OR
            (
                length(o->>'hgt') = 4 AND
                substring(o->>'hgt', 1,2)::int <@ int4range(59, 76, '[]') AND
                substring(o->>'hgt', 3,2) = 'in'
            )
        );
