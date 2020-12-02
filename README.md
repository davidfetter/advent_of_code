# advent_of_code
Code for the Advents!

# Curling and such

Here's what worked for me on Firefox in December of 2020:
- Install the Export Cookies addon if it's not already there
- Click it, and a menu pops up
- Choices are "all" and "current site."
- Choose the latter
- Remember where you put the file and what it was called. ~/cookies.txt is the
  default, but that's not great.
- Do the following to curl:
```sh
curl -b thatfile.cookie https://adventofcode.com/2020/day/1/input
```

You can also use tricks like
```sql
\copy mytab (cols, go, here) FROM PROGRAM $$curl -b thatfile.cookie https://adventofcode.com/2020/day/1/input$$
```
