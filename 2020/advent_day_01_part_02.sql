SELECT
    t1.amt AS a,
    t2.amt AS b,
    t3.amt AS c,
    t1.amt*t2.amt*t3.amt AS "product"
FROM
    er AS t1
JOIN
    er AS t2
    ON t1.amt + t2.amt < 1024
JOIN
    er AS t3 ON  t1.amt + t2.amt + t3.amt = 2020
ORDER BY
    t1.amt, t2.amt, t3.amt
FETCH FIRST ROW ONLY;
