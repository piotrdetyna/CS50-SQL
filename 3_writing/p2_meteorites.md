# Meteorite Cleaning

The "Meteorite Cleaning" assignment in CS50's Introduction to Databases with SQL involves working as a data engineer at NASA, focusing on cleaning data from a CSV file of historical meteorite landings on Earth. The task is to import this data into a SQLite database named meteorites.db, cleaning it in the process. Studcents need to download meteorites.csv and an import.sql file for writing SQL statements to clean the CSV data. 

The meteorites table in the database should include columns like id, name, class, mass, discovery, year, lat, and long, representing various attributes of the meteorites. The assignment emphasizes ensuring data integrity and accuracy in the cleaning process​.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/3/meteorites/](https://cs50.harvard.edu/sql/2023/psets/3/meteorites/)

<img src="https://piotr.detyna.pl/cs50-sql/week-3/meteorites.png" alt="Meteorites" style="width: 50%">

## Schema
- `id`, which represents the unique ID of the meteorite.
- `name`, which represents the given name of the meteorite.
- `class`, which is the classification of the meteorite, according to the traditional classification - scheme.
- `mass`, which is the weight of the meteorite, in grams.
- `discovery`, which is either “Fell” or “Found”. “Fell” indicates the meteorite was seen falling to - Earth, whereas “Found” indicates the meteorite was found only after landing on Earth.
- `year`, which is the year in which the the meteorite was discovered.
- `lat`, which is the latitude at which the meteorite landed.
- `long`, which is the longitude at which the meteorite landed.

## Specification and queries

To consider the data in the meteorites table clean, you should ensure…

- Any empty values in meteorites.csv are represented by NULL in the meteorites table.
  - Keep in mind that the mass, year, lat, and long columns have empty values in the CSV.
- All columns with decimal values (e.g., 70.4777) should be rounded to the nearest hundredths place (e.g., 70.4777 becomes 70.48).
  - Keep in mind that the mass, lat, and long columns have decimal values.
- All meteorites with the nametype “Relict” are not included in the meteorites table.
- The meteorites are sorted by year, oldest to newest, and then—if any two meteorites landed in the same year—by name, in alphabetical order.
- You’ve updated the IDs of the meteorites from meteorites.csv, according to the order specified in #4.
  - The id of the meteorites should start at 1, beginning with the meteorite that landed in the oldest year and is the first in alphabetical order for that year.

```
.import --csv meteorites.csv meteorites_temp
UPDATE meteorites_temp SET mass = NULL WHERE mass = '';
UPDATE meteorites_temp SET year = NULL WHERE year = '';
UPDATE meteorites_temp SET lat = NULL WHERE lat = '';
UPDATE meteorites_temp SET long = NULL WHERE long = '';

UPDATE meteorites_temp
SET mass = ROUND(mass, 2),
    lat = ROUND(lat, 2),
    long = ROUND(long, 2);


CREATE TABLE meteorites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    class TEXT,
    mass REAL,
    discovery TEXT,
    year INTEGER,
    lat REAL,
    long REAL
);

INSERT INTO meteorites (name, class, mass, discovery, year, lat, long)
SELECT name, class, mass, discovery, year, lat, long
    FROM meteorites_temp
    WHERE nametype != 'Relict'
    ORDER BY year, name;
```