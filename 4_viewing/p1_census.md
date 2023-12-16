# Census Taker problem

The "Census Taker" assignment in CS50's Introduction to Databases with SQL puts students in the role of a census taker for the Nepali government. The task involves processing data into views that can be used for governmental record-keeping. Students need to download census.db and several .sql files for writing their queries. 

The census table within the database contains columns like id, district, locality, families, households, population, male, and female, each providing crucial census data. The assignment focuses on writing SQL statements to create views of this data for effective analysis and record-keeping.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/4/census/](https://cs50.harvard.edu/sql/2023/psets/4/census/)

<img src="https://piotr.detyna.pl/cs50-sql/week-4/census.png" alt="Census taker" style="width: 50%">

## Schema
In census.db you’ll find a single table, census. In the census table, you’ll find the following columns:

- `id`, which uniquely identifies each census record
- `district`, which is the name of the census record’s district
- `locality`, which is the name of the census record’s locality within the district
- `families`, which is the number of families associated with the census record
- `households`, which is the total number of households associated with the census record (multiple families may live in the same household)
- `population`, which is the population associated with the census record
- `male`, which is the number of people associated with the census record who have identified as male
- `female`, which is the number of people associated with the census record who have identified as female

## Specification and queries

In each of the corresponding .sql files, write a SQL statement to create each of the following views of the data in census.db. Note that, while views can be created from other views, each of your views should stand alone (i.e., not rely on a prior view).

### Rural
In rural.sql, write a SQL statement to create a view named rural. This view should contain all census records relating to a rural municipality (identified by including “rural” in their name). Ensure the view contains all of the columns from the census table.
```
CREATE VIEW rural AS
SELECT *
FROM census
WHERE locality LIKE '%rural%';
```

### Total
In total.sql, write a SQL statement to create a view named total. This view should contain the sums for each numeric column in census, across all districts and localities. Ensure the view contains each of the following columns:

- families, which is the sum of families from every locality in Nepal.
- households, which is the sum of households from every locality in Nepal.
- population, which is the sum of the population from every locality in Nepal.
- male, which is the sum of people identifying as male from every locality in Nepal.
- female, which is the sum of people identifying as female from every locality in Nepal.
```
CREATE VIEW total AS
SELECT SUM(families) families,
    SUM(households) households,
    SUM(population) population,
    SUM(male) male,
    SUM(female) female
FROM census;
```

### By District
In by_district.sql, write a SQL statement to create a view named by_district. This view should contain the sums for each numeric column in census, grouped by district. Ensure the view contains each of the following columns:

- district, which is the name of the district.
- families, which is the total number of families in the district.
- households, which is the total number of households in the district.
- population, which is the total population of the district.
- male, which is the total number of people identifying as male in the district.
- female, which is the total number of people identifying as female in the district.
```
CREATE VIEW by_district AS
SELECT district,
    SUM(families) families,
    SUM(households) households,
    SUM(population) population,
    SUM(male) male,
    SUM(female) female
FROM census
GROUP BY district;
```

### Most Populated
In most_populated.sql, write a SQL statement to create a view named most_populated. This view should contain, in order from greatest to least, the most populated districts in Nepal. Ensure the view contains each of the following columns:

- district, which is the name of the district.
- families, which is the total number of families in the district.
- households, which is the total number of households in the district.
- population, which is the total population of the district.
- male, which is the total number of people identifying as male in the district.
- female, which is the total number of people identifying as female in the district.

```
CREATE VIEW most_populated AS
SELECT district,
    SUM(families) families,
    SUM(households) households,
    SUM(population) population,
    SUM(male) male,
    SUM(female) female
FROM census
GROUP BY district
ORDER BY population DESC;
```