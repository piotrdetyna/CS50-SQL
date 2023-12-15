# ATL problem

The "ATL" assignment in CS50's Introduction to Databases with SQL involves designing a database system for Hartsfield-Jackson International Airport (ATL), the world's busiest airport since 1998. Students are tasked with creating a SQLite database from scratch, writing `CREATE TABLE` statements in a schema.sql file. 

The database must track essential information about passengers (name and age), check-ins (date, time, and flight), airlines (name and concourse location), and flights (number, operating airline, departure and arrival airports, and times). The focus is on designing a database that meets the airport's operational needs and can represent the provided sample data​.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/2/atl/](https://cs50.harvard.edu/sql/2023/psets/2/atl/)

<img src="https://piotr.detyna.pl/cs50-sql/week-2/atl.jpeg" alt="ATL" style="width: 50%">

## Specification and schema

### Passengers
When it comes to our passengers, we just need to have the essentials in line: the first name, last name, and age. That’s all we need to know — nothing more.
```
CREATE TABLE passengers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 150),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 150),
    age INTEGER NOT NULL CHECK(age BETWEEN 0 AND 200)
);
```

### Check-Ins
When passengers arrive at ATL, they’ll often “check in” to their flights. That’s them telling us they’re here and all set to board. We’d like to keep a tidy log of such moments. And what would we need to log, you ask? Well, here’s what we need:
- The exact date and time at which our passenger checked in
- The flight they are checking in for, of course. Can’t lose track of where they’re headed, now can we?
```
CREATE TABLE check_ins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    datetime NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    flight_id INTEGER,
    passenger_id INTEGER,
    FOREIGN KEY (flight_id) REFERENCES flights(id) ON DELETE SET NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(id) ON DELETE CASCADE
);
```

### Airlines
ATL’s a hub for many domestic and international airlines: names like Delta, British Airways, Air France, Korean Air, and Turkish Airlines. The list goes on. So here’s what we track:
- The name of the airline
- The “concourse” or, shall I say, the section of our airport where the airline operates. We have 7 concourses: A, B, C, D, E, F, and T.

```
CREATE TABLE airlines (
    id INTEGER,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 300)
);

CREATE TABLE concourses (
    id TEXT PRIMARY KEY
);
-- Add default concourses
INSERT INTO concourses VALUES ('A'), ('B'), ('C'), ('D'), ('T');

CREATE TABLE operates (
    airline_id INTEGER,
    concourse_id INTEGER,
    FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE CASCADE,
    FOREIGN KEY (concourse_id) REFERENCES concourses(id) ON DELETE CASCADE
);
```

### Flights
We serve as many as 1,000 flights daily. To ensure that our passengers are never left wondering, we need to give them all the critical details about their flight. Here’s what we’d like to store:
- The flight number. For example, “900”. Just know that we sometimes re-use flight numbers.
- The airline operating the flight. You can keep it simple and assume one flight is operated by one airline.
- The code of the airport they’re departing from. For example, “ATL” or “BOS”.
- The code of the airport they’re heading to
- The expected departure date and time (to the minute, of course!)
- The expected arrival date and time, to the very same accuracy
```
CREATE TABLE flights (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    number INTEGER NOT NULL,
    airline_id INTEGER,
    departure_airport TEXT NOT NULL CHECK(length(departure_airport) == 3),
    arrival_airport TEXT NOT NULL CHECK(length(arrival_airport) == 3),
    expected_departure_datetime NUMERIC,
    expected_arrival_datetime NUMERIC,
    FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE SET NULL
);
```


### Full schema
```
CREATE TABLE passengers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 150),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 150),
    age INTEGER NOT NULL CHECK(age BETWEEN 0 AND 200)
);

CREATE TABLE check_ins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    datetime NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    flight_id INTEGER,
    passenger_id INTEGER,
    FOREIGN KEY (flight_id) REFERENCES flights(id) ON DELETE SET NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(id) ON DELETE CASCADE
);

CREATE TABLE airlines (
    id INTEGER,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 300)
);

CREATE TABLE flights (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    number INTEGER NOT NULL,
    airline_id INTEGER,
    departure_airport TEXT NOT NULL CHECK(length(departure_airport) == 3),
    arrival_airport TEXT NOT NULL CHECK(length(arrival_airport) == 3),
    expected_departure_datetime NUMERIC,
    expected_arrival_datetime NUMERIC,
    FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE SET NULL
);

CREATE TABLE concourses (
    id TEXT PRIMARY KEY
);

CREATE TABLE operates (
    airline_id INTEGER,
    concourse_id INTEGER,
    FOREIGN KEY (airline_id) REFERENCES airlines(id) ON DELETE CASCADE,
    FOREIGN KEY (concourse_id) REFERENCES concourses(id) ON DELETE CASCADE
);


-- Add default concourses
INSERT INTO concourses VALUES ('A'), ('B'), ('C'), ('D'), ('T');
```