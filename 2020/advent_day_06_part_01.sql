CREATE TABLE IF NOT EXISTS raw_day_06(id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, answer TEXT);
\copy raw_day_06 (answer) FROM PROGRAM 'curl -b cookies.txt https://adventofcode.com/2020/day/6/input'

WITH groups AS (
    SELECT COALESCE(lag(id) OVER (ORDER BY id), 0) + 1 AS start, id -1 AS end
    FROM raw_day_06
    WHERE answer = ''
UNION
    SELECT max(id) FILTER (WHERE answer = '') + 1 AS start, max(id) AS end
    FROM raw_day_06
)
SELECT sum(count(distinct ans)) OVER ()
FROM
    raw_day_06 r
JOIN
    groups g
ON (r.id >= g.start AND r.id <= g.end)
CROSS JOIN LATERAL (
    SELECT regexp_split_to_table(r.answer, '')
) AS s0(ans)
GROUP BY g.end
FETCH FIRST ROW ONLY;
