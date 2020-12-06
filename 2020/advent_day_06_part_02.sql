WITH groups AS (
    SELECT COALESCE(lag(id) OVER (ORDER BY id), 0) + 1 AS start, id -1 AS end, id - COALESCE(lag(id) OVER (ORDER BY id), 0) - 1 AS group_count
    FROM raw_day_06
    WHERE answer = ''
UNION
    SELECT max(id) FILTER (WHERE answer = '') + 1 AS start, max(id) AS end, max(id) - max(id) FILTER (WHERE answer = '') AS group_count
    FROM raw_day_06
),
all_said_yes AS (
    SELECT g.end, s0.ans, count(*) OVER (partition by g.end) AS yeses
    FROM
        raw_day_06 r
    JOIN
        groups g
    ON (r.id >= g.start AND r.id <= g.end)
    CROSS JOIN LATERAL (
        SELECT regexp_split_to_table(r.answer, '')
    ) AS s0(ans)
    GROUP BY g.end, s0.ans, g.group_count
    HAVING count(*) = g.group_count
    ORDER BY g.end, s0.ans
)
SELECT "end", yeses, sum(yeses) OVER ()
FROM all_said_yes
GROUP BY "end", yeses
FETCH FIRST ROW ONLY;
