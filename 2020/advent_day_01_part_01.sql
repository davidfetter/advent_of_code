SELECT
    t1.amt AS a,
    t2.amt AS b,
    t1.amt*t2.amt AS "product"
FROM
    er AS t1
JOIN er AS t2
    ON (
        t1.amt <= 1010 AND
        t1.amt + t2.amt = 2020
    );
