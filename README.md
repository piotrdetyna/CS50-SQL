
# Harvard CS50’s Introduction to Databases with SQL 
After completing (in one year!) the CS50x, CS50AI, CS50WEB and CS50CYBERSECURITY courses, I took the **CS50's Introduction to Databases with SQL** course. As with other courses offered by Harvard, it was a fascinating and enjoyable adventure. I learned many of the most important issues related to designing, managing, optimizing and scaling databases.

See more details: _https://cs50.harvard.edu/sql/2023/_

**Table of Contents:**
- [Harvard CS50’s Introduction to Databases with SQL](#harvard-cs50s-introduction-to-databases-with-sql)
  - [Course overview](#course-overview)
    - [Course program](#course-program)
  - [My certficate](#my-certficate)
  - [Week 0. Querying](#week-0-querying)
    - [Problem set](#problem-set)
      - [Cyberchase](#cyberchase)
      - [36 Views](#36-views)
      - [Normals](#normals)
      - [Players](#players)
  - [Week 1. Relating](#week-1-relating)
    - [Problem set](#problem-set-1)
      - [Packages, Please](#packages-please)
      - [DESE](#dese)
      - [Moneyball](#moneyball)
  - [Week 2. Designing](#week-2-designing)
    - [Problem set](#problem-set-2)
      - [ATL](#atl)
      - [Happy to Connect](#happy-to-connect)
      - [Union Square Donuts](#union-square-donuts)
  - [Week 3. Writing](#week-3-writing)
    - [Problem set](#problem-set-3)
      - [Don't Panic!](#dont-panic)
      - [Meteorite Cleaning](#meteorite-cleaning)
  - [Week 4. Viewing](#week-4-viewing)
    - [Problem set](#problem-set-4)
      - [Census Taker](#census-taker)
      - [The Private Eye](#the-private-eye)
      - [Bed and Breakfast](#bed-and-breakfast)
  - [Week 5. Optimizing](#week-5-optimizing)
    - [Problem set](#problem-set-5)
      - [your.harvard](#yourharvard)
  - [Week 6. Scaling](#week-6-scaling)
    - [Problem set](#problem-set-6)
      - [Happy to Connect (Sentimental)](#happy-to-connect-sentimental)
      - [Don’t Panic! (Sentimental) with Python](#dont-panic-sentimental-with-python)
      - [Don’t Panic! (Sentimental) with Java](#dont-panic-sentimental-with-java)
  - [Final Project](#final-project)





![Course header image](https://piotr.detyna.pl/cs50-sql/main.png)
## Course overview

**This is how the creators of the course introduces the course.**

This is CS50’s introduction to databases using a language called SQL. Learn how to create, read, update, and delete data with relational databases, which store data in rows and columns. Learn how to model real-world entities and relationships among them using tables with appropriate types, triggers, and constraints. 

Learn how to normalize data to eliminate redundancies and reduce potential for errors. Learn how to join tables together using primary and foreign keys. Learn how to automate searches with views and expedite searches with indexes. Learn how to connect SQL with other languages like Python and Java. 

Course begins with SQLite for portability’s sake and ends with introductions to PostgreSQL and MySQL for scalability’s sake as well. Assignments inspired by real-world datasets.

### Course program
The course lasts **7 weeks, each including 1-2 hours of lecture and 2-4 problems**. You can find my solutions in this repository.
- Week 0. **Querying**
- Week 1. **Relating**
- Week 2. **Designing**
- Week 3. **Writing**
- Week 4. **Viewing**
- Week 5. **Optimizing**
- Week 6. **Scaling**

## My certficate
![Certificate](https://piotr.detyna.pl/cs50-sql/certificate.png)
[https://cs50.harvard.edu/certificates/a2486d38-0691-4f29-8600-c72061427a48](https://cs50.harvard.edu/certificates/a2486d38-0691-4f29-8600-c72061427a48)

## Week 0. Querying
I have learned: Tables, Databases, Database Management Systems, SQL, SQLite, SELECT, LIMIT, OFFSET, WHERE, Comparisons, NOT, NULL, Pattern Matching, LIKE, Compound Conditions, Range Conditions, Ordering, Aggregate Functions, ROUND, DISTINCT.

![Week 0](https://piotr.detyna.pl/cs50-sql/week-0/main.jpg?)
### Problem set
These problems are really trivial, so feel free to move on to the next set.

#### Cyberchase
The "Cyberchase" assignment in CS50's Introduction to Databases with SQL involves using a database, cyberchase.db, to answer questions about episodes from the "Cyberchase" TV series. The database contains details like episode ID, season, title, topic, air date, and production code.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/0_querying/p1_cyberchase.md)

#### 36 Views
The "36 Views" assignment focuses on exploring views.db, a database containing information on 72 Japanese woodblock prints by artists Hokusai and Hiroshige, depicting various views of Mount Fuji. 

The database's single table, views, includes columns like print_number, english_title, japanese_title, artist, average_color, brightness, contrast, and entropy, providing detailed data on each print

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/0_querying/p2_views.md)

#### Normals
The "Normals" assignment in CS50's Introduction to Databases with SQL asks students to explore normals.db, a database that contains a table named normals. This table includes climate data for various global coordinates, detailing normal ocean temperatures at different depths (from the surface to 5500 meters deep).

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/0_querying/p3_normals.md)

#### Players

The "Players" assignment in CS50's Introduction to Databases with SQL involves analyzing a database named players.db, which contains a table called players. This table is dedicated to Major League Baseball (MLB) players and features detailed information such as the player's name, batting and throwing sides, weight, height, career debut and final game dates, birth details, and more. 

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/0_querying/p4_players.md)


## Week 1. Relating
I have learned: Relational Databases. Relationships: One-to-one, One-to-many, Many-to-many. Entity Relationship Diagrams. Keys: Primary Keys, Foreign Keys. Subqueries. IN. Joins: INNER JOIN, Outer Joins, LEFT JOIN, RIGHT JOIN, FULL JOIN, NATURAL JOIN. Sets: INTERSECT, UNION, EXCEPT. Groups: GROUP BY, HAVING.

![Week 1](https://piotr.detyna.pl/cs50-sql/week-1/main.jpg)

### Problem set
These tasks were very interesting, and I particularly enjoyed the first one.

#### Packages, Please
The "Packages, Please" assignment simulates the role of a mail clerk in Boston, responsible for solving mysteries related to missing packages. 

The database encompasses entities such as drivers, packages, addresses, and package scans, with tables like addresses, drivers, packages, and scans that store relevant data. 

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/1_relating/p1_packages.md)

#### DESE

The "DESE" assignment tasks students with the role of a data analyst for the Massachusetts Department of Elementary and Secondary Education (DESE). 

Utilizing the dese.db database, students must answer questions about the state's education system. This database represents the relationship between school districts, schools, graduation rates, expenditures, and staff evaluations in Massachusetts.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/1_relating/p2_dese.md)

#### Moneyball

The "Moneyball" assignment is based on the 2001 Oakland Athletics baseball team's challenge to build a competitive team despite a limited budget. 

The database includes tables for players, teams, performances, and salaries, detailing various aspects like player ID, team name, types of hits, and salary amounts. Students are tasked with writing SQL queries using this database to uncover valuable players that may be overlooked by others

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/1_relating/p3_moneyball.md)


## Week 2. Designing
I have learned: Schemas. Normalizing. Data Types. Storage Classes. Type Affinities. Table Constraints: PRIMARY KEY, FOREIGN KEY. Column Constraints: CHECK, DEFAULT, NOT NULL, UNIQUE. Altering Tables: DROP TABLE, ALTER TABLE, ADD COLUMN, RENAME COLUMN, DROP COLUMN. Charlie.

![Week 2](https://piotr.detyna.pl/cs50-sql/week-2/main.jpg?)

### Problem set
I also liked these tasks because they showed real-life examples and I had to deal with real problems.

#### ATL
The "ATL" assignment involves designing a database system for Hartsfield-Jackson International Airport (ATL), the world's busiest airport since 1998. Students are tasked with creating a SQLite database from scratch, writing CREATE TABLE statements in a schema.sql file. The database must track essential information about passengers (name and age), check-ins (date, time, and flight), airlines (name and concourse location), and flights (number, operating airline, departure and arrival airports, and times).

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/2_designing/p1_atl.md)

#### Happy to Connect

The "Happy to Connect" assignment involves creating a database for LinkedIn. Students are required to write a set of CREATE TABLE statements in a schema.sql file to design this database from scratch. 

The database must include information about LinkedIn users (their names, usernames, and passwords), educational institutions (names, types, locations), companies (names, industries, locations), and connections between people, schools, and companies. This involves storing data about mutual connections between users, affiliations with schools and companies, and details like start and end dates of affiliations, degree types, and job titles.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/2_designing/p2_connect.md)


#### Union Square Donuts

The "Donuts" assignment in CS50's Introduction to Databases with SQL involves designing a database for Union Square Donuts. Students must create this database from scratch, using CREATE TABLE statements in a schema.sql file. 

The database is required to manage various aspects of the donut shop's operations, including tracking ingredients and their prices, details of donuts (name, gluten-free status, price), recording online orders (order numbers, donuts ordered, and customer information), and maintaining customer data (names and order history). The focus is on fulfilling the shop's operational needs and representing sample data provided in the assignment.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/2_designing/p3_donuts.md)



## Week 3. Writing
I have learned: Create, Read, Update, Delete. INSERT INTO. CSVs. .import. DELETE FROM. Foreign Key Constraints. UPDATE. Triggers. Soft Deletions.


![Week 3](https://piotr.detyna.pl/cs50-sql/week-3/main.jpg?)

### Problem set
From these tasks, I learned more about importing from CSV, data cleansing, and more.


#### Don't Panic!
The "Don't Panic!" assignment in CS50's Introduction to Databases with SQL casts students in the role of a "pentester" (penetration tester) tasked with testing the security of a SQLite database that powers a website. 

The assignment involves a series of covert operations, including altering the administrative account's password, erasing any logs of this password change, and adding false data to mislead the company. 

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/3_writing/p1_dont_panic.md)

#### Meteorite Cleaning
The "Meteorite Cleaning" assignment in CS50's Introduction to Databases with SQL involves working as a data engineer at NASA, focusing on cleaning data from a CSV file of historical meteorite landings on Earth. The task is to import this data into a SQLite database named meteorites.db, cleaning it in the process. Students need to download meteorites.csv and an import.sql file for writing SQL statements to clean the CSV data.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/3_writing/p2_meteorites.md)



## Week 4. Viewing  
I have learned: Views. CREATE VIEW. Views for Simplifying. Views for Aggregating. Temporary Views. CREATE TEMPORARY VIEW. Common Table Expressions. Views for Partitioning. Views for Securing. Soft Deletions.


![Week 4](https://piotr.detyna.pl/cs50-sql/week-4/main.jpg?)

### Problem set

#### Census Taker

The "Census Taker" assignment in CS50's Introduction to Databases with SQL puts students in the role of a census taker for the Nepali government. The task involves processing data into views that can be used for governmental record-keeping. 

The census table within the database contains columns like id, district, locality, families, households, population, male, and female, each providing crucial census data. The assignment focuses on writing SQL statements to create views of this data for effective analysis and record-keeping​

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/4_viewing/p1_census.md)

#### The Private Eye

The "Private Eye" assignment in CS50's Introduction to Databases with SQL involves a detective-themed challenge where students must decode a cipher.

The main task is to decode a cipher left by a detective, creating a view named message in the database. This view should have a single column, phrase, which, when queried, reveals phrases of the message. Students need to write all necessary SQL statements in private.sql to replicate the creation of this view, including creating any additional tables and inserting data as needed.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/4_viewing/p2_private.md)

#### Bed and Breakfast

The "Bed and Breakfast" assignment in CS50's Introduction to Databases with SQL involves analyzing the influence of AirBnB on Boston's tourism industry. Students are tasked with developing views within the bnb.db database, requiring them to download this database along with several .sql files for query writing. 

They must create views to portray various aspects of AirBnB's impact, such as listing details without descriptions, properties with one bedroom, availability data, most frequently reviewed listings, and vacancies in June 2023. The assignment is focused on providing insights into AirBnB's role in altering local accommodation dynamics.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/4_viewing/p3_bnb.md)



## Week 5. Optimizing  
I have learned: Indexes. CREATE INDEX. EXPLAIN QUERY PLAN. Covering Indexes. B-Trees. Partial Indexes. VACUUM. Concurrency. Transactions. ACID: Atomicity, Consistency, Isolation, Durability. BEGIN TRANSACTION. COMMIT. ROLLBACK. Race Conditions. Locks.

![Week 5](https://piotr.detyna.pl/cs50-sql/week-5/main.jpg)

### Problem set

#### your.harvard

The "your.harvard" assignment in CS50's Introduction to Databases with SQL challenges students to improve the performance of Harvard's course shopping tool, my.harvard, by optimizing a database. Students need to download harvard.db and an indexes.sql file, where they will write SQL statements to create indexes. The database includes tables like students, courses, enrollments, requirements, and satisfies, each containing various relevant columns.

The task involves creating indexes that speed up typical queries on the database, considering the balance between speed and disk space, and ensuring the efficient representation of Harvard's courses and students

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/5_optimizing/p1_harvard.md)


## Week 6. Scaling  
I have learned: Scalability. MySQL: Integers, Strings, Dates, Times, Real Numbers, Floating-Point Imprecision, Fixed Precision, Altering Tables. Stored Procedures. PostgreSQL. Vertical Scaling. Horizontal Scaling. Replication. Read Replicas. Sharding. Access Controls: GRANT, REVOKE. SQL Injection Attacks. Prepared Statements.

![Week 6](https://piotr.detyna.pl/cs50-sql/week-6/main.jpg?)

### Problem set

#### Happy to Connect (Sentimental)

The "Happy to Connect" assignment in CS50's Introduction to Databases with SQL involves creating a MySQL database schema for LinkedIn. The task requires designing a database from scratch, where students must write SQL statements in a file called schema.sql in the sentimental-connect folder. The database should accurately represent LinkedIn's users, schools, companies, and their connections. The connections include user affiliations with schools and companies, including start and end dates, and types of degrees or job titles held.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/6_scaling/p1_connect.md)

#### Don’t Panic! (Sentimental) with Python

The "Don’t Panic!" assignment in CS50's Introduction to Databases with SQL involves a scenario where students, as trained penetration testers, are hired to assess and report vulnerabilities in a data system. This iteration of the assignment requires **writing a Python program to automate the hacking process**. The key tasks are to connect to a SQLite database (dont-panic.db) using Python and alter the administrator’s password within the Python program.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/6_scaling/p2_dont_panic_python.md)

#### Don’t Panic! (Sentimental) with Java

The "Don’t Panic!" assignment in CS50's Introduction to Databases with SQL, Java version, puts students in the role of a pentester hired to test and report vulnerabilities in a company's data system. Students are tasked with automating their hack by writing a Java program. The main objectives include connecting to a SQLite database (dont-panic.db) using Java and **altering the administrator’s password within the Java program**.

[Read more and see my queries](https://github.com/piotrdetyna/CS50-SQL/blob/master/6_scaling/p3_dont_panic_java.md)

![Final Project](https://piotr.detyna.pl/cs50-sql/final-project/main.jpg?)
## Final Project
I had to build something that was of interest to me, something that solved a substantive problem, positively impacted others, or changed the world. I strive to create something I am proud of.

[See the project](https://github.com/piotrdetyna/CS50-SQL/blob/master/final_project/DESIGN.md)
