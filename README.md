# Harvard CS50’s Introduction to Databases with SQL
After completing (in one year!) the CS50x, CS50AI, CS50WEB and CS50CYBERSECURITY courses, I took the **CS50's Introduction to Databases with SQL** course. As with other courses offered by Harvard, it was a fascinating and enjoyable adventure. I learned many of the most important issues related to designing, managing, optimizing and scaling databases.

See more details: _https://cs50.harvard.edu/sql/2023/_
![Course header image](https://piotr.detyna.pl/cs50-sql/main.png)
## Course overview

**This is how the creators of the course introduces the course.**

This is CS50’s introduction to databases using a language called SQL. Learn how to create, read, update, and delete data with relational databases, which store data in rows and columns. Learn how to model real-world entities and relationships among them using tables with appropriate types, triggers, and constraints. 

Learn how to normalize data to eliminate redundancies and reduce potential for errors. Learn how to join tables together using primary and foreign keys. Learn how to automate searches with views and expedite searches with indexes. Learn how to connect SQL with other languages like Python and Java. 

Course begins with SQLite for portability’s sake and ends with introductions to PostgreSQL and MySQL for scalability’s sake as well. Assignments inspired by real-world datasets.

### Course program
The course lasts **7 weeks, each including 1-2 hours of lecture and 3-4 problems**. You can find my solutions in this repository.
- Week 0. **Querying**
- Week 1. **Relating**
- Week 2. **Designing**
- Week 3. **Writing**
- Week 4. **Viewing**
- Week 5. **Optimizing**
- Week 6. **Scaling**

## Week 0. Quering
I have learned: Tables, Databases, Database Management Systems, SQL, SQLite, SELECT, LIMIT, OFFSET, WHERE, Comparisons, NOT, NULL, Pattern Matching, LIKE, Compound Conditions, Range Conditions, Ordering, Aggregate Functions, ROUND, DISTINCT.

### Problem set
These problems are really trivial, so feel free to move on to the next set.

#### Cyberchase
The "Cyberchase" assignment in CS50's Introduction to Databases with SQL involves using a database, cyberchase.db, to answer questions about episodes from the "Cyberchase" TV series. The database contains details like episode ID, season, title, topic, air date, and production code.

[Read more and see my queries](0_querying/p1_cyberchase.md)

#### 36 Views
The "36 Views" assignment focuses on exploring views.db, a database containing information on 72 Japanese woodblock prints by artists Hokusai and Hiroshige, depicting various views of Mount Fuji. 

The database's single table, views, includes columns like print_number, english_title, japanese_title, artist, average_color, brightness, contrast, and entropy, providing detailed data on each print

[Read more and see my queries](0_querying/p2_views.md)

#### Normals
The "Normals" assignment in CS50's Introduction to Databases with SQL asks students to explore normals.db, a database that contains a table named normals. This table includes climate data for various global coordinates, detailing normal ocean temperatures at different depths (from the surface to 5500 meters deep).

[Read more and see my queries](0_querying/p3_normals.md)

#### Players

The "Players" assignment in CS50's Introduction to Databases with SQL involves analyzing a database named players.db, which contains a table called players. This table is dedicated to Major League Baseball (MLB) players and features detailed information such as the player's name, batting and throwing sides, weight, height, career debut and final game dates, birth details, and more. 

[Read more and see my queries](0_querying/p4_players.md)