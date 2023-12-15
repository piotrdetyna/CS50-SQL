# Players problem

The "Players" assignment in CS50's Introduction to Databases with SQL involves analyzing a database named players.db, which contains a table called players. This table is dedicated to Major League Baseball (MLB) players and features detailed information such as the player's name, batting and throwing sides, weight, height, career debut and final game dates, birth details, and more. 


See full problem: [https://cs50.harvard.edu/sql/2023/psets/0/players/](https://cs50.harvard.edu/sql/2023/psets/0/players/)
![Views](https://piotr.detyna.pl/cs50-sql/week-0/players.jpeg)

## Schema
- **players** table:
  - **id**, which uniquely identifies each row (player) in the table
  - **first_name**, which is the first name of the player
  - **last_name**, which is the last name of the player
  - **bats**, which is the side (R for right or L for left) the player bats on
  - **throws**, which is the hand (R for right or L for left) the player throws with
  - **weight**, which is the player’s weight in pounds
  - **height**, which is the player’s height in inches
  - **debut**, which is the date (expressed as YYYY-MM-DD) the player began their career in the MLB
  - **final_game**, which is the date (expressed as YYYY-MM-DD) the player played their last game in the MLB
  - **birth_year**, which is the year the player was born
  - **birth_month**, which is the month (expressed as an integer) the player was born
  - **birth_day**, which is the day the player was born
  - **birth_city**, which is the city in which the player was born
  - **birth_state**, which is the state in which the player was born
  - **birth_country**, which is the country in which the player was born


## Specification and my solutions
- In 1.sql, write a SQL query to find the hometown (including city, state, and country) of Jackie Robinson.
    ```
    SELECT 
        birth_city, 
        birth_state, 
        birth_country
    FROM players
    WHERE first_name = 'Jackie'
        AND last_name = 'Robinson'
    ```
- In 2.sql, write a SQL query to find the side (e.g., right or left) Babe Ruth hit.
    ```
    SELECT bats
    FROM players
    WHERE first_name = 'Babe'
        AND last_name = 'Ruth'
    ```
- In 3.sql, write a SQL query to find the ids of rows for which a value in the column debut is missing.

    ```
    SELECT id
    FROM players
    WHERE debut IS NULL
    ```
- In 4.sql, write a SQL query to find the first and last names of players who were not born in the United States. Sort the results alphabetically by first name, then by last name.

    ```
    SELECT first_name, last_name
    FROM players
    WHERE birth_country != 'USA'
    ORDER BY first_name, last_name
    ```
- In 5.sql, write a SQL query to return the first and last names of all right-handed batters. Sort the results alphabetically by first name, then by last name.

    ```
    SELECT first_name, last_name
    FROM players
    WHERE bats = 'R'
    ORDER BY first_name, last_name
    ```
- In 6.sql, write a SQL query to return the first name, last name, and debut date of players born in Pittsburgh, Pennsylvania (PA). Sort the results first by debut date—from most recent to oldest—then alphabetically by first name, followed by last name.

    ```
    SELECT 
        first_name, 
        last_name, 
        debut
    FROM players
    WHERE birth_city = 'Pittsburgh'
        AND birth_state = 'PA'
    ORDER BY debut DESC, 
        first_name, 
        last_name
    ```
- In 7.sql, write a SQL query to count the number of players who bat (or batted) right-handed and throw (or threw) left-handed, or vice versa.

    ```
    SELECT COUNT(id)
    FROM players
    WHERE
        (bats = 'R' AND throws = 'L')
        OR (bats = 'L' AND throws = 'R')
    ```
- In 8.sql, write a SQL query to find the average height and weight, rounded to two decimal places, of baseball players who debuted on or after January 1st, 2000. Return the columns with the name “Average Height” and “Average Weight”, respectively.

    ```
    SELECT 
        ROUND(AVG(height), 2) AS "Average Height",
        ROUND(AVG(weight), 2) AS "Average Weight"
    FROM players
    WHERE strftime('%Y', debut) >= '2000'

    ```
- In 9.sql, write a SQL query to find the players who played their final game in the MLB in 2022. Sort the results alphabetically by first name, then by last name.

    ```
    SELECT first_name, last_name
    FROM players
    WHERE final_game BETWEEN
        '2022-01-01' AND '2022-12-31'
    ORDER BY first_name, last_name
    ```
- In 10.sql, write SQL query to answer a question of your choice. This query should:
  - Make use of AS to rename a column
  - Involve at least condition, using WHERE
  - Sort by at least one column using ORDER BY
    
    ```
    SELECT 
        birth_country, 
        COUNT(*) AS players_count
    FROM players
    WHERE height > 50
    GROUP BY birth_country
    ORDER BY birth_country
    ```
### Feeling more comfortable? (Of course!)
- Write a single SQL query to list the first and last names of all players of above average height, sorted tallest to shortest, then by first and last name.
    ```
    SELECT first_name, last_name
    FROM players
    WHERE height > (
        SELECT AVG(height) 
        FROM players
    )
    ORDER BY 
        height DESC, 
        first_name, 
        last_name
    ```