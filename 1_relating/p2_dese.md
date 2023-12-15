# DESE problem
The "DESE" assignment in CS50's Introduction to Databases with SQL tasks students with the role of a data analyst for the Massachusetts Department of Elementary and Secondary Education (DESE). 

Utilizing the dese.db database, students must answer questions about the state's education system. This database represents the relationship between school districts, schools, graduation rates, expenditures, and staff evaluations in Massachusetts. 

It contains several tables, including districts, schools, graduation_rates, expenditures, and staff_evaluations, each providing specific data like district and school names, graduation rates, per-pupil expenditure, and staff evaluation metrics. 

See full problem: [https://cs50.harvard.edu/sql/2023/psets/1/dese/](https://cs50.harvard.edu/sql/2023/psets/1/dese/)

![DESE](https://piotr.detyna.pl/cs50-sql/week-1/dese.png)

## Schema
- **districts table**
  - `id`: ID of the district
  - `name`: Name of the district
  - `type`: Type of district (Public School District, Charter District)
  - `city`: City in which the district is located
  - `state`: State in which the district is located
  - `zip`: ZIP Code in which the district is located

- **schools table**
  - `id`: ID of the school
  - `district_id`: ID of the district to which the school belongs
  - `name`: Name of the school
  - `type`: Type of school (Public School, Charter School)
  - `city`: City in which the school is located
  - `state`: State in which the school is located
  - `zip`: ZIP Code in which the school is located

- **graduation_rates table**
  - `id`: ID of the graduation rate
  - `school_id`: ID of the school with which the graduation rate is associated
  - `graduated`: Percentage of students (0–100) who graduated on time
  - `dropped`: Percentage of students (0–100) who dropped out of school
  - `excluded`: Percentage of students (0–100) who were excluded (i.e., expelled)

- **expenditures table**
  - `id`: ID of the expenditure
  - `district_id`: ID of the district with which the expenditure is associated
  - `pupils`: Number of pupils attending the district
  - `per_pupil_expenditure`: Amount of money spent on each student (in dollars)

- **staff_evaluations table**
  - `id`: ID of the evaluation report
  - `district_id`: ID of the district with which the evaluation is associated
  - `evaluated`: Percentage of district staff (0–100) formally evaluated
  - `exemplary`: Percentage of district staff (0–100) evaluated as “exemplary”
  - `proficient`: Percentage of district staff (0–100) evaluated as “proficient”
  - `needs_improvement`: Percentage of district staff (0–100) evaluated as “needing improvement”
  - `unsatisfactory`: Percentage of district staff (0–100) evaluated as “unsatisfactory”



## Specification and my solutions
1. **1.sql**: 
   Your colleague is preparing a map of all public schools in Massachusetts. Write a SQL query to find the names and cities of all public schools in Massachusetts. Remember that not all schools in the schools table are traditional public schools. Massachusetts also recognizes charter schools, which are considered distinct according to DESE.
   ```
   SELECT name, city
    FROM schools
    WHERE type = 'Public School'
   ```

2. **2.sql**: 
   Your team is working on archiving old data. Write a SQL query to find the names of districts that are no longer operational. Districts that are no longer operational have “(non-op)” at the end of their name.
    ```
    SELECT name
    FROM districts
    WHERE name LIKE '%(non-op)';
   ```

3. **3.sql**: 
   The Massachusetts Legislature would like to learn how much money, on average, districts spent per-pupil last year. Write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”. Note that the per_pupil_expenditure column in the expenditures table contains the average amount, per pupil, each district spent last year. You’re asked to find the average of this set of averages, weighting all districts equally regardless of their size.
    ```
    SELECT AVG(expenditures.per_pupil_expenditure) "Average District Per-Pupil Expenditure"
    FROM districts JOIN expenditures 
        ON districts.id = expenditures.district_id
    ```

4. **4.sql**: 
   Some cities have more public schools than others. Write a SQL query to find the 10 cities with the most public schools. Your query should return the names of the cities and the number of public schools within them, ordered from the greatest number of public schools to the least. If two cities have the same number of public schools, order them alphabetically.
    ```
    SELECT city, COUNT(id) schools
    FROM schools
    WHERE type = 'Public School'
    GROUP BY city
    ORDER BY schools DESC, city
    LIMIT 10
   ```

5. **5.sql**: 
   DESE would like you to determine in what cities additional public schools might be needed. Write a SQL query to find cities with 3 or fewer public schools. Your query should return the names of the cities and the number of public schools within them, ordered from the greatest number of public schools to the least. If two cities have the same number of public schools, order them alphabetically.
    ```
    SELECT city, 
        COUNT(id) schools
    FROM schools
    WHERE type = 'Public School'
    GROUP BY city
    HAVING schools <= 3
    ORDER BY schools DESC, city

   ```

6. **6.sql**: 
   DESE wants to assess which schools achieved a 100% graduation rate. Write a SQL query to find the names of schools (public or charter) that reported a 100% graduation rate.
    ```
    SELECT schools.name
    FROM schools JOIN graduation_rates 
        ON schools.id = graduation_rates.school_id
    WHERE graduation_rates.graduated = 100
   ```

7. **7.sql**: 
   DESE is preparing a report on schools in the Cambridge school district. Write a SQL query to find the names of all schools in the Cambridge school district.
    ```
    SELECT schools.name
    FROM schools JOIN districts 
        ON districts.id = schools.district_id
    WHERE districts.name = 'Cambridge'
   ```

8. **8.sql**: 
   A parent wants to send their child to a district with many other students. Write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
    ```
    SELECT districts.name, expenditures.pupils
    FROM districts JOIN expenditures
        ON districts.id = expenditures.district_id
   ```

9. **9.sql**: 
   Another parent wants to send their child to a district with few other students. Write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. Report only the name(s).
    ```
    SELECT districts.name
    FROM districts JOIN expenditures
        ON districts.id = expenditures.district_id
    WHERE expenditures.pupils = (
        SELECT MIN(expenditures.pupils)
        FROM expenditures
    )
   ```

10. **10.sql**: 
    In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values. Write a SQL query to find the 10 public school districts with the highest per-pupil expenditures. Your query should return the names of the districts and the per-pupil expenditure for each.
    ```
    SELECT districts.name, 
        expenditures.per_pupil_expenditure
    FROM districts JOIN expenditures 
        ON districts.id = expenditures.district_id
    WHERE districts.type = 'Public School District'
    ORDER BY expenditures.per_pupil_expenditure DESC
    LIMIT 10
    ```

11. **11.sql**: 
    Is there a relationship between school expenditures and graduation rates? Write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, sort by school name. Assume a school spends the same amount per-pupil as their district does.
    ```
    SELECT schools.name, expenditures.per_pupil_expenditure, graduation_rates.graduated
    FROM schools JOIN expenditures
        ON schools.district_id = expenditures.district_id
    JOIN graduation_rates
        ON schools.id = graduation_rates.school_id
    ORDER BY expenditures.per_pupil_expenditure DESC, 
        schools.name
    ```

12. **12.sql**: 
    A parent asks you for advice on finding the best public school districts in Massachusetts. Write a SQL query to find public school districts with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”. Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary. Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
    ```
    SELECT districts.name,
        expenditures.per_pupil_expenditure,
        staff_evaluations.exemplary
    FROM districts JOIN expenditures
        ON expenditures.district_id = districts.id
    JOIN staff_evaluations
        ON staff_evaluations.district_id = districts.id
    WHERE districts.type = 'Public School District'
        AND expenditures.per_pupil_expenditure > (
            SELECT AVG(per_pupil_expenditure) FROM expenditures
        )
        AND staff_evaluations.exemplary > (
            SELECT AVG(exemplary) FROM staff_evaluations
        )
    ORDER BY staff_evaluations.exemplary DESC,
        expenditures.per_pupil_expenditure DESC;
    ```

13. **13.sql**: 
    Write a SQL query to answer a question you have about the data! The query should involve at least one JOIN or subquery.
    ```
    SELECT districts.name,
        schools.name,
        AVG(graduation_rates.graduated) graduated_percentage,
        AVG(graduation_rates.dropped) dropped_percentage,
        AVG(graduation_rates.excluded) excluded_percentage
    FROM schools JOIN graduation_rates
        ON graduation_rates.school_id = schools.id
    JOIN districts 
        ON districts.id = schools.id
    GROUP BY districts.id, 
        schools.id
    ORDER BY graduated_percentage DESC, 
        dropped_percentage DESC, 
        excluded_percentage DESC
    ```
