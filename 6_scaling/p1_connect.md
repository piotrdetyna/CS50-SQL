# Happy to Connect (sentimental) problem


The "Happy to Connect" assignment in CS50's Introduction to Databases with SQL involves creating a `MySQL` database schema for LinkedIn. The task requires designing a database from scratch, where students must write SQL statements in a file called schema.sql in the sentimental-connect folder. The database should accurately represent LinkedIn's users, schools, companies, and their connections. 

The connections include user affiliations with schools and companies, including start and end dates, and types of degrees or job titles held. Sample data and scenarios are provided for students to ensure their database design can effectively capture real-world information about users, educational institutions, and companies​

See full problem: [https://cs50.harvard.edu/sql/2023/psets/6/connect/](https://cs50.harvard.edu/sql/2023/psets/6/connect/)

<img src="https://piotr.detyna.pl/cs50-sql/week-6/connect.png" alt="connect" style="width: 50%">

## Specification and schema

### Users
The heart of LinkedIn’s platform is its people. Your database should be able to represent the following information about LinkedIn’s users:
- Their first and last name
- Their username
- Their password
Note: Keep in mind that, if a company is following best practices, application passwords are “hashed.” No need to worry about hashing passwords here, though.
```
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    user_name VARCHAR(64) NOT NULL CHECK(user_name NOT IN ('login', 'logout')),
    password CHAR(64) NOT NULL -- SHA256 hash
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
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    type VARCHAR(64) NOT NULL,
    location VARCHAR(128),
    foundation_year INT
);
```

### Companies
LinkedIn allows companies to create their own pages, like the one for LinkedIn itself, so employees can identify their past or current employment with the company. Ensure that LinkedIn’s database can store the following information for each company:
- The name of the company
- The company’s industry (e.g., “Education”, “Technology, “Finance”, etc.)
- The company’s location
```
CREATE TABLE companies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    industry VARCHAR(64) NOT NULL,
    location VARCHAR(128)
);
```

### Connections with People
LinkedIn’s database should be able to represent mutual (reciprocal, two-way) connections between users. No need to worry about one-way connections, such as user A “following” user B without user B “following” user A.
```
CREATE TABLE follows (
    user_a INT,
    user_b INT,
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
    user_id INT,
    school_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    degree_type ENUM("Bachelor's Degree", "Master's Degree", "Doctorate Degree (Ph.D.)"),
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
    user_id INT,
    company_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    title VARCHAR(64),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);
```

## Full schema
```
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    user_name VARCHAR(64) NOT NULL CHECK(user_name NOT IN ('login', 'logout')),
    password CHAR(64) NOT NULL -- SHA256 hash
);

CREATE TABLE schools (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    type VARCHAR(64) NOT NULL,
    location VARCHAR(128),
    foundation_year INT
);

CREATE TABLE companies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    industry VARCHAR(64) NOT NULL,
    location VARCHAR(128)
);

CREATE TABLE follows (
    user_a INT,
    user_b INT,
    FOREIGN KEY (user_a) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (user_b) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE school_affiliations (
    user_id INT,
    school_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    degree_type ENUM("Bachelor's Degree", "Master's Degree", "Doctorate Degree (Ph.D.)"),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE
);

CREATE TABLE company_affiliations (
    user_id INT,
    company_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    title VARCHAR(64),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
);
```