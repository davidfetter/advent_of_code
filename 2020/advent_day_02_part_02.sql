/*
         rule_and_pass
═══════════════════════════════
 6-7 w: wwhmzwtwwk
 10-12 q: qqqqqqqqqqqdqqq
 16-17 d: ddddgdddddkddddsxddd
 2-4 q: shbqwqpps
 3-4 q: qkfq
 2-10 m: bkdrmcfdhmr
 13-19 s: blccvhsgsnsssqszssm
 1-3 l: qlxllhl
 4-6 h: hhhqhhh
 15-17 l: jrtllrlllllmmlllg
(10 rows)
*/
SELECT
    count(*) AS "matches"
FROM
    harass_passwords
WHERE
    /* 1: 1st position
       2: 2nd position
       3: letter
       4: string
    (
        regexp_match(
            rule_and_pass,
            '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
        )
    )
   */
    (
        substring(
            (
                regexp_match(
                    rule_and_pass,
                    '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
                )
            )[4],
            (
                regexp_match(
                    rule_and_pass,
                    '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
                )
            )[1]::int,
            1
        )
        =
        (
            regexp_match(
                rule_and_pass,
                '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
            )
        )[3]
    )::int
    +
    (
        substring(
            (
                regexp_match(
                    rule_and_pass,
                    '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
                )
            )[4],
            (
                regexp_match(
                    rule_and_pass,
                    '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
                )
            )[2]::int,
            1
        )
        =
        (
            regexp_match(
                rule_and_pass,
                '([[:digit:]]+)-([[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
            )
        )[3]
    )::int
    = 1;
