# Moneyball problem

The "Moneyball" assignment in CS50's Introduction to Databases with SQL is based on the 2001 Oakland Athletics baseball team's challenge to build a competitive team despite a limited budget. In this assignment, students use the moneyball.db database, which contains information on Major League Baseball players, teams, their performances, and salaries up until 2001. 

The database includes tables for players, teams, performances, and salaries, detailing various aspects like player ID, team name, types of hits, and salary amounts. Students are tasked with writing SQL queries using this database to uncover valuable players that may be overlooked by others.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/1/moneyball/](https://cs50.harvard.edu/sql/2023/psets/1/moneyball/)
![Moneyball](https://piotr.detyna.pl/cs50-sql/week-1/moneyball.png)

## Schema
- **players table**
  - `id`: ID of the player
  - `first_name`: First name of the player
  - `last_name`: Last name of the player
  - `bats`: Side the player bats on (R for right, L for left)
  - `throws`: Hand the player throws with (R for right, L for left)
  - `weight`: Player’s weight in pounds
  - `height`: Player’s height in inches
  - `debut`: Date (YYYY-MM-DD) the player began their MLB career
  - `final_game`: Date (YYYY-MM-DD) the player played their last MLB game
  - `birth_year`: Year the player was born
  - `birth_month`: Month (as an integer) the player was born
  - `birth_day`: Day the player was born
  - `birth_city`: City in which the player was born
  - `birth_state`: State in which the player was born
  - `birth_country`: Country in which the player was born

- **teams table**
  - `id`: ID of the team
  - `year`: Year the team was founded
  - `name`: Name of the team
  - `park`: Name of the park where the team plays

- **performances table**
  - `id`: ID of the performance
  - `player_id`: ID of the player who generated the performance
  - `team_id`: ID of the team for which the performance was generated
  - `year`: Year of the performance
  - `G`: Number of games played by the player
  - `AB`: Player’s number of at bats
  - `H`: Player’s number of hits
  - `2B`: Player’s number of doubles
  - `3B`: Player’s number of triples
  - `HR`: Player’s number of home runs
  - `RBI`: Player’s number of runs batted in
  - `SB`: Player’s number of stolen bases

- **salaries table**
  - `id`: ID of the salary
  - `player_id`: ID of the player earning the salary
  - `team_id`: ID of the team paying the salary
  - `year`: Year during which the salary was paid
  - `salary`: Salary amount in US dollars


## Specification and my solutions
1. **1.sql**
   - Write a SQL query to find the average player salary by year.
   - Sort by year in descending order.
   - Round the salary to two decimal places and call the column “average salary”.
   - The query should return a table with two columns, one for year and one for average salary.

    ```
    SELECT year,
        ROUND(AVG(salary), 2) "average salary"
    FROM salaries
    GROUP BY year
    ORDER BY year DESC
    ```

2. **2.sql**
   - Write a SQL query to find Cal Ripken Jr.’s salary history.
   - Sort by year in descending order.
   - The query should return a table with two columns, one for year and one for salary.

    ```
    SELECT year, 
        salary "average salary"
    FROM salaries JOIN players 
        ON players.id = salaries.player_id
    WHERE players.first_name = 'Cal'
        AND players.last_name = 'Ripken'
    GROUP BY year
    ORDER BY year DESC
    ```

3. **3.sql**
   - Write a SQL query to find Ken Griffey Jr.’s home run history.
   - Sort by year in descending order.
   - Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
   - The query should return a table with two columns, one for year and one for home runs.

    ```
    SELECT performances.year, 
        performances.HR
    FROM performances JOIN players 
        ON performances.player_id = players.id
    WHERE players.first_name = 'Ken'
        AND players.last_name = 'Griffey'
        AND players.birth_year = 1969
    ORDER BY performances.year DESC
    ```

4. **4.sql**
   - Write a SQL query to find the 50 players paid the least in 2001.
   - Sort players by salary, lowest to highest.
   - If two players have the same salary, sort alphabetically by first name and then by last name.
   - If two players have the same first and last name, sort by player ID.
   - The query should return three columns, one for players’ first names, one for their last names, and one for their salaries.

    ```
    SELECT players.first_name, 
        players.last_name, 
        salaries.salary
    FROM players JOIN salaries 
        ON players.id = salaries.player_id
    WHERE salaries.year = 2001
    ORDER BY salaries.salary, 
        players.first_name, 
        players.last_name, 
        players.id
    LIMIT 50
    ```

5. **5.sql**
   - Write a SQL query to find all teams that Satchel Paige played for.
   - The query should return a table with a single column, one for the name of the teams.

    ```
    SELECT DISTINCT teams.name
    FROM teams JOIN performances 
        ON teams.id = performances.team_id
    JOIN players 
        ON performances.player_id = players.id
    WHERE players.first_name = 'Satchel'
        AND players.last_name = 'Paige'
    ```

6. **6.sql**
   - Write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
   - Call the column representing total hits by players in 2001 “total hits”.
   - Sort by total hits, highest to lowest.
   - The query should return two columns, one for the teams’ names and one for their total hits in 2001.

    ```
    SELECT teams.name, 
        SUM(performances.H) "total hits"
    FROM teams JOIN performances 
        ON teams.id = performances.team_id
    WHERE performances.year = 2001
    GROUP BY performances.team_id
    ORDER BY "total hits" DESC
    LIMIT 5
    ```

7. **7.sql**
   - Write a SQL query to find the name of the player who’s been paid the highest salary, of all time, in Major League Baseball.
   - The query should return a table with two columns, one for the player’s first name and one for their last name.

    ```
    SELECT players.first_name, 
        players.last_name
    FROM players JOIN salaries 
        ON players.id = salaries.player_id
    WHERE salaries.salary = (
        SELECT MAX(salary) 
        FROM salaries
    )
    ```

8. **8.sql**
   - Write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
   - The query should return a table with one column, the salary of the player.

    ```
    SELECT salaries.salary
    FROM players JOIN performances 
        ON players.id = performances.player_id
    JOIN salaries 
        ON players.id = salaries.player_id
    WHERE performances.HR = (
            SELECT MAX(HR)
            FROM performances
            WHERE year = 2001
        )
        AND salaries.year = 2001

    ```

9. **9.sql**
   - Write a SQL query to find the 5 lowest paying teams (by average salary) in 2001.
   - Round the average salary column to two decimal places and call it “average salary”.
   - Sort the teams by average salary, least to greatest.
   - The query should return a table with two columns, one for the teams’ names and one for their average salary.

    ```
    SELECT teams.name, 
        ROUND(AVG(salaries.salary), 2) "average salary"
    FROM teams JOIN salaries 
        ON teams.id = salaries.team_id
    WHERE salaries.year = 2001
    GROUP BY teams.id
    ORDER BY "average salary"
    LIMIT 5
    ```

10. **10.sql**
    - Write a query to return a table with the following details for each player:
      - All player’s first names
      - All player’s last names
      - All player’s salaries
      - All player’s home runs
      - The year in which the player was paid that salary and hit those home runs
    - Order the results, first and foremost, by player’s IDs (least to greatest).
    - Order rows about the same player by year, in descending order.
    - For a player with multiple salaries or performances for a given year, order them first by number of home runs, in descending order, followed by salary, in descending order.
    - Ensure that, for a single row, the salary’s year and the performance’s year match.

    ```
    SELECT players.first_name, 
        players.last_name, 
        salaries.salary, 
        performances.HR, 
        salaries.year
    FROM players JOIN salaries 
        ON players.id = salaries.player_id
    JOIN performances 
        ON players.id = performances.player_id
    WHERE performances.year = salaries.year
    ORDER BY players.id, 
        performances.year DESC, 
        performances.HR DESC, 
        salaries.salary DESC
    ```

11. **11.sql**
    - Write a SQL query to find the 10 least expensive players per hit in 2001.
    - The query should return a table with three columns, one for the players’ first names, one of their last names, and one called “dollars per hit”.
    - Calculate the “dollars per hit” column by dividing a player’s 2001 salary by the number of hits they made in 2001. Use AS to rename a column.
    - Dividing a salary by 0 hits will result in a NULL value. Filter out players with 0 hits.
    - Sort the table by the “dollars per hit” column, least to most expensive. If two players have the same “dollars per hit”, order by first name, followed by last name, in alphabetical order.
    - Ensure that the salary’s year and the performance’s year match.

    ```
    SELECT players.first_name,
        players.last_name, 
        (salaries.salary / performances.H) "dollars per hit"
    FROM players JOIN salaries 
        ON players.id = salaries.player_id
    JOIN performances 
        ON players.id = performances.player_id
    WHERE performances.H > 0
        AND salaries.year = 2001
        AND performances.year = 2001
    ORDER BY "dollars per hit",
        first_name, 
        last_name
    LIMIT 10;
    ```

12. **12.sql**
    - Write a SQL query to find the players among the 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001.
    - The query should return a table with two columns, one for the players’ first names and one of their last names.
    - Calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
    - Order your results by player ID, least to greatest (or alphabetically by last name, as both are the same in this case!).
    - Keep in mind the lessons from 10.sql and 11.sql.

    ```
    SELECT players.first_name,
        players.last_name
    FROM players,
        (
            SELECT players.id, 
                (salaries.salary / performances.RBI) "dollars per RBI"
            FROM players JOIN salaries 
                ON players.id = salaries.player_id
            JOIN performances 
                ON players.id = performances.player_id
            WHERE performances.RBI > 0
                AND salaries.year = 2001
                AND performances.year = 2001
            ORDER BY "dollars per RBI", 
                first_name, 
                last_name
            LIMIT 10
        ) by_rbis,
        (
            SELECT players.id, 
                (salaries.salary / performances.H) "dollars per hit"
            FROM players JOIN salaries
                ON players.id = salaries.player_id
            JOIN performances 
                ON players.id = performances.player_id
            WHERE performances.H > 0
                AND salaries.year = 2001
                AND performances.year = 2001
            ORDER BY "dollars per hit", 
                first_name, 
                last_name
            LIMIT 10
        ) by_hits
    WHERE by_rbis.id = by_hits.id
        AND players.id = by_rbis.id
    ORDER BY players.id
    ```
