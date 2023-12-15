# Cyberchase problem

The assignment "Cyberchase" from CS50's Introduction to Databases with SQL involves exploring a database named cyberchase.db, which contains a table called episodes. This table includes columns such as id, season, episode_in_season, title, topic, air_date, and production_code, representing various details of episodes from the animated series "Cyberchase"​. 

See full problem: [https://cs50.harvard.edu/sql/2023/psets/0/cyberchase](https://cs50.harvard.edu/sql/2023/psets/0/cyberchase)
![Cyberchase](https://piotr.detyna.pl/cs50-sql/week-0/cyberchase.jpg)

## Schema
- **episodes** table:
  - **id**, which uniquely identifies each row (episode) in the table
  - **season**, which is the season number in which the episode aired
  - **episode_in_season**, which is the episode’s number within its given season
  - **title**, which is the episode’s title
  - **topic**, which identifies the ideas the episode aimed to teach
  - **air_date**, which is the date (expressed as YYYY-MM-DD) on which the episode “aired” (i.e., was published)
  - **production_code**, which is the unique ID used by PBS to refer to each episode internally

##
- In 1.sql, write a SQL query to list the titles of all episodes in Cyberchase’s original season, Season 1.
    ```
    SELECT title
    FROM episodes
    WHERE season = 1;
    ```
- In 2.sql, list the season number of, and title of, the first episode of every season.
    ```
    SELECT season, title
    FROM episodes
    WHERE episode_in_season = 1
    ```
- In 3.sql, find the production code for the episode “Hackerized!”.
    ```
    SELECT production_code
    FROM episodes
    WHERE title = 'Hackerized!'
    ```
- In 4.sql, write a query to find the titles of episodes that do not yet have a listed topic.
    ```
    SELECT title
    FROM episodes
    WHERE topic IS NULL
    ```
- In 5.sql, find the title of the holiday episode that aired on December 31st, 2004.
    ```
    SELECT title
    FROM episodes
    WHERE air_date = '2004-12-31'
    ```
- In 6.sql, list the titles of episodes from season 6 (2008) that were released early, in 2007.
    ```
    SELECT title
    FROM episodes
    WHERE season = 6
        AND air_date LIKE '2007%'
    ```
- In 7.sql, write a SQL query to list the titles and topics of all episodes teaching fractions.
    ```
    SELECT title, topic
    FROM episodes
    WHERE topic LIKE '%fractions%'
    ```
- In 8.sql, write a query that counts the number of episodes released in the last 6 years, from 2018 to 2023, inclusive.
    
    You might find it helpful to know you can use BETWEEN with dates, such as BETWEEN '2000-01-01' AND '2000-12-31'.

    ```
    SELECT COUNT(*) count
    FROM episodes
    WHERE air_date BETWEEN '2018-01-01' AND '2023-12-31'
    ```

- In 9.sql, write a query that counts the number of episodes released in Cyberchase’s first 6 years, from 2002 to 2007, inclusive.
    ```
    SELECT COUNT(*) count
    FROM episodes
    WHERE air_date BETWEEN '2002-01-01' AND '2007-12-31'
    ```
- In 10.sql, write a SQL query to list the ids, titles, and production codes of all episodes. Order the results by production code, from earliest to latest.
    ```
    SELECT id, title, production_code
    FROM episodes
    ORDER BY production_code
    ```
- In 11.sql, list the titles of episodes from season 5, in reverse alphabetical order.
    ```
    SELECT title
    FROM episodes
    WHERE season = 5
    ORDER BY title DESC
    ```
- In 12.sql, count the number of unique episode titles.
    ```
    SELECT COUNT(DISTINCT title)
    FROM episodes
    ```
- In 13.sql, write a SQL query to explore a question of your choice. This query should:
  Involve at least one condition, using WHERE with AND or OR
    ```
    SELECT title, topic
    FROM episodes
    WHERE season BETWEEN 1 AND 3
        AND (
            topic LIKE '%fractions%'
            OR topic LIKE '%money%'
        )
    ```
### Feeling more comfortable? (Yes, i was :] )
- Write a SQL query to find the titles of episodes that have aired during the holiday season, usually in December in the United States.

    Your query should output a table with a single column for the title of each episode.
    Try to find a better solution than LIKE if you can!
    ```
    SELECT title
    FROM episodes
    WHERE strftime('%m', air_date) = '12'
    ```

- Write a SQL query to find, for each year, the first day of the year that PBS released a Cyberchase episode.
Your query should output a table with two columns, one for the year and one for the earliest month and day an episode was released that year.
    ```
    SELECT
        strftime('%Y', air_date) AS year,
        MIN(strftime('%m-%d', air_date)) AS month_day
    FROM episodes
    GROUP BY strftime('%Y', air_date)
    ```