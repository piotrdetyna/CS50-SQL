# your.harvard problem

The "your.harvard" assignment in CS50's Introduction to Databases with SQL challenges students to improve the performance of Harvard's course shopping tool, my.harvard, by optimizing a database. Students need to download harvard.db and an indexes.sql file, where they will write SQL statements to create indexes. 

The database includes tables like students, courses, enrollments, requirements, and satisfies, each containing various relevant columns. The task involves creating indexes that speed up typical queries on the database, considering the balance between speed and disk space, and ensuring the efficient representation of Harvard's courses and students

See full problem: [https://cs50.harvard.edu/sql/2023/psets/5/your.harvard/](https://cs50.harvard.edu/sql/2023/psets/5/your.harvard/)

<img src="https://piotr.detyna.pl/cs50-sql/week-5/harvard.png" alt="your.harvard" style="width: 50%">

## Schema
- **students table**
  - `id`: Student’s ID
  - `name`: Student’s name

- **courses table**
  - `id`: Course's ID
  - `department`: Department in which the course is taught (e.g., Computer Science, Economics, Philosophy)
  - `number`: Course number (e.g., 50, 12, 330)
  - `semester`: Semester in which the class was taught (e.g., Spring 2024, Fall 2023)
  - `title`: Title of the course (e.g., Introduction to Computer Science)

- **enrollments table**
  - `id`: ID to identify the enrollment
  - `student_id`: ID of the student enrolled
  - `course_id`: ID of the course in which the student is enrolled

- **requirements table**
  - `id`: ID of the requirement
  - `name`: Name of the requirement

- **satisfies table**
  - `id`: ID of the course-requirement pair
  - `course_id`: ID of a given course
  - `requirement_id`: ID of the requirement which the given course satisfies


## Specification and queries

In indexes.sql, write a set of SQL statements that create indexes which will speed up typical queries on the harvard.db database. The number of indexes you create, as well as the columns they include, is entirely up to you. Be sure to balance speed with disk space, only creating indexes you need.

When engineers optimize a database, they often care about the typical queries run on the database. Such queries highlight patterns with which a database is accessed, thus revealing the best columns and tables on which to create indexes. Click the spoiler tags below to see the set of typical queries run on harvard.db.

### INDEXES
```
CREATE INDEX students_id_index ON students(id);
CREATE INDEX courses_id_index ON courses(id);
CREATE INDEX enrollments_course_id_index ON enrollments(course_id);
CREATE INDEX enrollments_student_id_index ON enrollments(student_id);
CREATE INDEX courses_semester_index ON courses(semester);
CREATE INDEX requirements_id_index ON requirements(id);
CREATE INDEX satisfies_course_id_index ON satisfies(course_id);
CREATE INDEX courses_title_index ON courses(title);
```

### Typical SELECT queries on harvard.db

- Find a student’s historical course enrollments, based on their ID:

    ```SELECT "courses"."title", "courses"."semester"
    FROM "enrollments"
    JOIN "courses" ON "enrollments"."course_id" = "courses"."id"
    JOIN "students" ON "enrollments"."student_id" = "students"."id"
    WHERE "students"."id" = 3;
    ```
    - Without index: Run Time: real 0.202 user 0.188016 sys 0.013799
    - With index: Run Time: real 0.001 user 0.000616 sys 0.000055
    - Indexes used by this query:
        - SEARCH students USING COVERING INDEX students_id_index
        - SEARCH enrollments USING COVERING INDEX enrollments_students_courses_id_index

- Find all students who enrolled in Computer Science 50 in Fall 2023:
    ```
    SELECT "id", "name"
    FROM "students"
    WHERE "id" IN (
        SELECT "student_id"
        FROM "enrollments"
        WHERE "course_id" = (
            SELECT "id"
            FROM "courses"
            WHERE "courses"."department" = 'Computer Science'
            AND "courses"."number" = 50
            AND "courses"."semester" = 'Fall 2023'
        )
    );
    ```
    - Without index: Run Time: real 0.216 user 0.215243 sys 0.000643
    - With index: Run Time: real 0.002 user 0.001039 sys 0.000673
    - Indexes used by this query:
        - SEARCH enrollments USING INDEX enrollments_course_id_index
        - SEARCH courses USING INDEX courses_semester_index

- Sort courses by most- to least-enrolled in Fall 2023:
    ```SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title", COUNT(*) AS "enrollment"
    FROM "courses"
    JOIN "enrollments" ON "enrollments"."course_id" = "courses"."id"
    WHERE "courses"."semester" = 'Fall 2023'
    GROUP BY "courses"."id"
    ORDER BY "enrollment" DESC;
    ```
    - Without index: Run Time: real 1.332 user 1.236118 sys 0.037567
    - With index: Run Time: real 0.039 user 0.014399 sys 0.017307
    - Indexes used by this query:
        - SEARCH courses USING INDEX courses_semester_index
        - SEARCH enrollments USING COVERING INDEX enrollments_course_id_index
- Find all computer science courses taught in Spring 2024:
    ```
    SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title"
    FROM "courses"
    WHERE "courses"."department" = 'Computer Science'
    AND "courses"."semester" = 'Spring 2024';
    ```
    - Without index: Run Time: real 0.006 user 0.000000 sys 0.004899
    - With index: Run Time: real 0.003 user 0.002858 sys 0.000000
    - Indexes used by this query:
        - SEARCH courses USING INDEX courses_semester_index
- Find the requirement satisfied by “Advanced Databases” in Fall 2023:
    ```
    SELECT "requirements"."name"
    FROM "requirements"
    WHERE "requirements"."id" = (
        SELECT "requirement_id"
        FROM "satisfies"
        WHERE "course_id" = (
            SELECT "id"
            FROM "courses"
            WHERE "title" = 'Advanced Databases'
            AND "semester" = 'Fall 2023'
        )
    );
    ```
    - Without index: Run Time: real 0.003 user 0.002167 sys 0.000110
    - With index: Run Time: real 0.001 user 0.001270 sys 0.000123
    - Indexes used by this query:
        - SEARCH satisfies USING INDEX satisfies_course_id_index
        - SEARCH courses USING INDEX courses_title_index

- Find how many courses in each requirement a student has satisfied:
    ```
    SELECT "requirements"."name", COUNT(*) AS "courses"
    FROM "requirements"
    JOIN "satisfies" ON "requirements"."id" = "satisfies"."requirement_id"
    WHERE "satisfies"."course_id" IN (
        SELECT "course_id"
        FROM "enrollments"
        WHERE "enrollments"."student_id" = 8
    )
    GROUP BY "requirements"."name";
    ```
    - Without index: Run Time: real 0.199 user 0.188319 sys 0.009470
    - With index: Run Time: real 0.000 user 0.000000 sys 0.000475
    - Indexes used by this query:
        - SEARCH satisfies USING INDEX satisfies_course_id_index
        - SEARCH enrollments USING COVERING INDEX enrollments_students_courses_id_index
- Search for a course by title and semester:
    ```
    SELECT "department", "number", "title"
    FROM "courses"
    WHERE "title" LIKE "History%"
    AND "semester" = 'Fall 2023';
    ```
    - Without index: Run Time: real 0.012 user 0.001029 sys 0.007719
    - With index: Run Time: real 0.002 user 0.000000 sys 0.001804
    - Indexes used by this query:
        - SEARCH courses USING INDEX courses_semester_index