# 36 Views problem
The "36 Views" assignment focuses on exploring views.db, a database containing information on 72 Japanese woodblock prints by artists Hokusai and Hiroshige, depicting various views of Mount Fuji. 

The database's single table, views, includes columns like print_number, english_title, japanese_title, artist, average_color, brightness, contrast, and entropy, providing detailed data on each print

See full problem: [https://cs50.harvard.edu/sql/2023/psets/0/views/](https://cs50.harvard.edu/sql/2023/psets/0/views/)

<img src="https://piotr.detyna.pl/cs50-sql/week-0/views.jpeg" alt="Views" style="width: 50%">


## Schema
- **views** table:
  - `id`, which uniquely identifies each row (print) in the table
  - `print_number`, which identifies the number of the print in either Hokusai’s or Hiroshige’s series
  - `english_title`, which is the English title of the print
  - `japanese_title`, which is the Japanese title of the print
  - `artist`, which is the last name of the print’s artist
  - `average_color`, which is the hexadecimal representation of the color found by averaging the colors of each pixel in the image
  - `brightness`, which is a number corresponding to the overall lightness or darkness of the image
  - `contrast`, which is a number representing the extent of the difference between light and dark areas of the image
  - `entropy`, which is a measure used to quantify the complexity of the artwork

## Specification and my solutions
- In 1.sql, write a SQL query that a translator might take interest in: list, side by side, the Japanese title and the English title for each print. Ensure the Japanese title is the first column, followed by the English title.
    ```
    SELECT japanese_title, english_title
    FROM views  
    ```
- In 2.sql, write a SQL query to list the average colors of prints by Hokusai that include “river” in the English title. (As an aside, do they have any hint of blue?)
    ```
    SELECT average_color
    FROM views
    WHERE artist = 'Hokusai'
        AND english_title LIKE '%river%'
    ```
- In 3.sql, write a SQL query to count how many prints by Hokusai include “Fuji” in the English title. Though all of Hokusai’s prints focused on Mt. Fuji, in how many did “Fuji” make it into the title?
    ```
    SELECT COUNT(*)
    FROM views
    WHERE english_title LIKE '%Fuji%'
        AND artist = 'Hokusai'
    ```

- In 4.sql, write a SQL query to count how many prints by Hiroshige have English titles that refer to the “Eastern Capital”. Hiroshige’s prints were created in Japan’s “Edo period,” referencing the eastern capital city of Edo, now Tokyo.
    ```
    SELECT COUNT(*)
    FROM views
    WHERE english_title LIKE '%Eastern Capital%'
        AND artist = 'Hiroshige'
    ```

- In 5.sql, write a SQL query to find the highest contrast value of prints by Hokusai. Name the column “Maximum Contrast”. Does Hokusai’s prints most contrasting print actually have much contrast?
    ```
    SELECT MAX(contrast) "Maximum Contrast"
    FROM views
    WHERE artist = 'Hokusai'
    ```
- In 6.sql, write a SQL query to find the average entropy of prints by Hiroshige, rounded to two decimal places. Call the resulting column “Hiroshige Average Entropy”.
    ```
    SELECT ROUND(AVG(entropy), 2) "Hiroshige Average Entropy"
    FROM views
    WHERE artist = 'Hiroshige'
    ```
- In 7.sql, write a SQL query to list the English titles of the 5 brightest prints by Hiroshige, from most to least bright. Compare them to this list on Wikipedia to see if your results match the print’s aesthetics.
    ```
    SELECT english_title
    FROM views
    WHERE artist = 'Hiroshige'
    ORDER BY brightness DESC
    LIMIT 5
    ```
- In 8.sql, write a SQL query to list the English titles of the 5 prints with the least contrast by Hokusai, from least to highest contrast. Compare them to this list on Wikipedia to see if your results match the print’s aesthetics.
    ```
    SELECT english_title
    FROM views
    WHERE artist = 'Hokusai'
    ORDER BY contrast
    LIMIT 5
    ```
- In 9.sql, write a SQL query to find the English title and artist of the print with the highest brightness.
    ```
    SELECT english_title, artist
    FROM views
    ORDER BY brightness DESC
    LIMIT 1
    ```
- In 10.sql, write a SQL query to answer a question of your choice about the prints. The query should:
Make use of AS to rename a column
Involve at least one condition, using WHERE
Sort by at least one column, using ORDER BY
    ```
    SELECT artist, 
        MIN(brightness) AS min_brightness, 
        MAX(brightness) AS max_brightness
    FROM views
    WHERE contrast > 0.1
    GROUP BY artist
    ORDER BY min_brightness
    ```
