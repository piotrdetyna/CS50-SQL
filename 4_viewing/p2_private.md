# The Private Eye problem

The "Private Eye" assignment in CS50's Introduction to Databases with SQL involves a detective-themed challenge where students must decode a cipher. Students are required to download private.db and private.sql for this task​​. The database, private.db, contains a table called sentences with all sentences from "The Adventures of Sherlock Holmes," each identified by an id and the sentence itself​​.

The main task is to decode a cipher left by a detective, creating a view named message in the database. This view should have a single column, phrase, which, when queried, reveals phrases of the message. Students need to write all necessary SQL statements in private.sql to replicate the creation of this view, including creating any additional tables and inserting data as needed. The end goal is for private.sql, when run on a fresh instance of private.db, to fully reconstruct the view

See full problem: [https://cs50.harvard.edu/sql/2023/psets/4/private/](https://cs50.harvard.edu/sql/2023/psets/4/private/)

<img src="https://piotr.detyna.pl/cs50-sql/week-4/private.png?" alt="The Private Eye" style="width: 50%">

## Schema
Within private.db, you’ll find a table, sentences. The sentences table contains all sentences in The Adventures of Sherlock Holmes. In particular, it contains the following columns:

- `id`, which is the ID of the sentence
- `sentence`, which is the sentence itself

## Message to decode
|   sentence_id  |  start   | length  |
|-----|-----|---|
| 14  | 98  | 4 |
| 114 | 3   | 5 |
| 618 | 72  | 9 |
| 630 | 7   | 3 |
| 932 | 12  | 5 |
| 2230| 50  | 7 |
| 2346| 44  | 10|
| 3041| 14  | 5 |


## Specification and queries

Your task at hand is to decode the cipher left for you by the detective. How you do so is up to you, but you should ensure that—at the end of your process—you have a view structured as follows:

- The view should be named message
- The view should have a single column, phrase
- When the following SQL query is executed on private.db, your view should return a single column in which each row is one phrase in the message.

    `SELECT "phrase" FROM "message";`

In private.sql, you should write all SQL statements required to replicate your creation of the view. That is:

- If creating the view requires creating a separate table and inserting data into it, you should ensure that private.sql contains the statements to create that table and insert that data. (Don’t be afraid to add tables and add data as you wish!)
- `private.sql`, when run a fresh instance of private.db, should be able to fully reconstruct your view.

```
CREATE TABLE triplets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sentence_id INTEGER,
    length INTEGER,
    start INTEGER,
    FOREIGN KEY (sentence_id) REFERENCES sentences(id) ON DELETE CASCADE
);

INSERT INTO triplets (sentence_id, start, length)
VALUES (14, 98, 4),
    (114, 3, 5),
    (618, 72, 9),
    (630, 7, 3),
    (932, 12, 5),
    (2230, 50, 7),
    (2346, 44, 10),
    (3041, 14, 5);

CREATE VIEW message AS
SELECT SUBSTR(sentences.sentence, triplets.start, triplets.length) phrase
FROM triplets JOIN sentences 
    ON triplets.sentence_id = sentences.id;
```