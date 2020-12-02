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
    /* Strip the string of all non-matching characters */
    regexp_replace(
        /* string */
        (
            regexp_match(
                rule_and_pass,
                '([[:digit:]]+-[[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
            )
        )[3],
        /* regex */
        format(
            '[^%s]+',
            (
                regexp_match(
                    rule_and_pass,
                    '([[:digit:]]+-[[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
                )
            )[2]
        ),
        /* replacement */
        '',
        /* flags */
        'g'
    )
    ~
    format(
        '^%s{%s}$',
        /* character */
        (regexp_match(rule_and_pass, '([[:digit:]]+-[[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'))[2],
        /* count */
        replace(
            (
                regexp_match(
                    rule_and_pass,
                    '([[:digit:]]+-[[:digit:]]+) ([[:alnum:]]): ([[:alnum:]]+)'
                )
            )[1],
            '-',
            ','
        )
    );
