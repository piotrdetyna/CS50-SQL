# Happy to Connect problem

The "Happy to Connect" assignment in CS50's Introduction to Databases with SQL involves creating a database for LinkedIn. Students are required to write a set of CREATE TABLE statements in a schema.sql file to design this database from scratch. 

The database must include information about LinkedIn users (their names, usernames, and passwords), educational institutions (names, types, locations), companies (names, industries, locations), and connections between people, schools, and companies. 

This involves storing data about mutual connections between users, affiliations with schools and companies, and details like start and end dates of affiliations, degree types, and job titles.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/2/connect/](https://cs50.harvard.edu/sql/2023/psets/2/connect/)

<img src="https://piotr.detyna.pl/cs50-sql/week-2/connect.png" alt="Connect" style="width: 50%">

## Specification and schema

### Users
The heart of LinkedIn’s platform is its people. Your database should be able to represent the following information about LinkedIn’s users:
- Their first and last name
- Their username
- Their password
Note: Keep in mind that, if a company is following best practices, application passwords are “hashed.” No need to worry about hashing passwords here, though.
```
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 100),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 100),
    user_name TEXT NOT NULL CHECK(length(user_name) BETWEEN 1 AND 100 AND user_name NOT IN ('login', 'logout')),
    password TEXT NOT NULL
);
```

### Schools and Universities
LinkedIn also allows for official school or university accounts, such as that for Harvard, so alumni (i.e., those who’ve attended) can identify their affiliation. Ensure that LinkedIn’s database can store the following information about each school:
- The name of the school
- The type of school (e.g., “Elementary School”, “Middle School”, “High School”, “Lower School”, “Upper School”, “College”, “University”, etc.)
- The school’s location
- The year in which the school was founded
```
CREATE TABLE schools (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 200),
    type TEXT NOT NULL CHECK(length(type) BETWEEN 1 AND 100),
    location TEXT CHECK(length(location) BETWEEN 1 AND 250),
    foundation_year INTEGER
);
```

### Companies
LinkedIn allows companies to create their own pages, like the one for LinkedIn itself, so employees can identify their past or current employment with the company. Ensure that LinkedIn’s database can store the following information for each company:
- The name of the company
- The company’s industry (e.g., “Education”, “Technology, “Finance”, etc.)
- The company’s location
```
CREATE TABLE companies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 200),
    industry TEXT NOT NULL CHECK(length(industry) BETWEEN 1 AND 100),
    location TEXT CHECK(length(location) BETWEEN 1 AND 250)
);
```

### Connections with People
LinkedIn’s database should be able to represent mutual (reciprocal, two-way) connections between users. No need to worry about one-way connections, such as user A “following” user B without user B “following” user A.
```
CREATE TABLE follows (
    user_a INTEGER,
    user_b INTEGER,
    FOREIGN KEY (user_a) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (user_b) REFERENCES users(id) ON DELETE CASCADE
);
```

### Connections with Schools
A user should be able to create an affiliation with a given school. And similarly, that school should be able to find its alumni. Additionally, allow a user to define:
- The start date of their affiliation (i.e., when they started to attend the school)
- The end date of their affiliation (i.e., when they graduated), if applicable
- The type of degree earned/pursued (e.g., “BA”, “MA”, “PhD”, etc.)
```
CREATE TABLE school_affiliations (
    user_id INTEGER,
    school_id INTEGER,
    start_date NUMERIC NOT NULL,
    end_date NUMERIC,
    degree_type TEXT CHECK(length(degree_type) BETWEEN 1 AND 50),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);
```

### Connections with Companies
A user should be able to create an affiliation with a given company. And similarly, a company should be able to find its current and past employees. Additionally, allow a user to define:
- The start date of their affiliation (i.e., the date they began work with the company)
- The end date of their affiliation (i.e., when left the company), if applicable
- The title they held while affiliated with the company
```
CREATE TABLE company_affiliations (
    user_id INTEGER,
    company_id INTEGER,
    start_date NUMERIC NOT NULL,
    end_date NUMERIC,
    title TEXT CHECK(length(title) BETWEEN 1 AND 50),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);
```

## Full schema
```
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 100),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 100),
    user_name TEXT NOT NULL CHECK(length(user_name) BETWEEN 1 AND 100 AND user_name NOT IN ('login', 'logout')),
    password TEXT NOT NULL
);

CREATE TABLE schools (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 200),
    type TEXT NOT NULL CHECK(length(type) BETWEEN 1 AND 100),
    location TEXT CHECK(length(location) BETWEEN 1 AND 250),
    foundation_year INTEGER
);

CREATE TABLE companies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 200),
    industry TEXT NOT NULL CHECK(length(industry) BETWEEN 1 AND 100),
    location TEXT CHECK(length(location) BETWEEN 1 AND 250)
);

CREATE TABLE follows (
    user_a INTEGER,
    user_b INTEGER,
    FOREIGN KEY (user_a) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (user_b) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE school_affiliations (
    user_id INTEGER,
    school_id INTEGER,
    start_date NUMERIC NOT NULL,
    end_date NUMERIC,
    degree_type TEXT CHECK(length(degree_type) BETWEEN 1 AND 50),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);

CREATE TABLE company_affiliations (
    user_id INTEGER,
    company_id INTEGER,
    start_date NUMERIC NOT NULL,
    end_date NUMERIC,
    title TEXT CHECK(length(title) BETWEEN 1 AND 50),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);
```