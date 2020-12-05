SELECT
    ticket IS NULL AND
    lead(ticket) OVER (ORDER BY i) IS NOT NULL AND
    lag(ticket) OVER (ORDER BY i) IS NOT NULL AS "is_it",
    i
FROM
    generate_series(0,1023) AS s(i)
LEFT JOIN
    raw_day_05 ON i = translate(ticket, 'FBLR', '0101')::bit(10)::int
ORDER BY 1 DESC
FETCH FIRST ROW ONLY;
