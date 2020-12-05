CREATE TABLE raw_day_05(id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, ticket TEXT);
\copy raw_day_05 (ticket) FROM PROGRAM 'curl -b cookies.txt https://adventofcode.com/2020/day/5/input'

SELECT max(translate(ticket, 'FBLR', '0101')::bit(10)::int) FROM raw_day_05;
