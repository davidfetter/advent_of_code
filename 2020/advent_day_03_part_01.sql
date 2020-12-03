/*
CREATE TABLE trees(id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, pat TEXT);
\copy trees (pat) FROM PROGRAM 'curl -b cookies.txt https://adventofcode.com/2020/day/3/input'
*/

SELECT count(*)
FROM trees
WHERE substr(pat, (3 * (id -1) % 31 + 1), 1) = '#';
