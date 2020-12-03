SELECT
    count(*) FILTER (WHERE substr(pat, (1 * (id -1) % 31 + 1), 1) = '#') *
    count(*) FILTER (WHERE substr(pat, (3 * (id -1) % 31 + 1), 1) = '#') *
    count(*) FILTER (WHERE substr(pat, (5 * (id -1) % 31 + 1), 1) = '#') *
    count(*) FILTER (WHERE substr(pat, (7 * (id -1) % 31 + 1), 1) = '#') *
    count(*) FILTER (WHERE id % 2 = 1 AND substr(pat, (((id -1)/2) % 31 + 1), 1) = '#') AS "product"
FROM trees;
