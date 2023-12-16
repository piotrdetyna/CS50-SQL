# Bed and Breakfast problem

The "Bed and Breakfast" assignment in CS50's Introduction to Databases with SQL involves analyzing the influence of AirBnB on Boston's tourism industry. Students are tasked with developing views within the bnb.db database, requiring them to download this database along with several .sql files for query writing. 

They must create views to portray various aspects of AirBnB's impact, such as listing details without descriptions, properties with one bedroom, availability data, most frequently reviewed listings, and vacancies in June 2023. The assignment is focused on providing insights into AirBnB's role in altering local accommodation dynamics.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/4/bnb/](https://cs50.harvard.edu/sql/2023/psets/4/bnb/)

<img src="https://piotr.detyna.pl/cs50-sql/week-4/bnb.png?" alt="BnB" style="width: 50%">

## Schema
- **listings table**
  - `id`: ID of the listing
  - `property_type`: Type of the listing (e.g., Entire rental unit, Private room in rental unit)
  - `host_name`: Airbnb username of the listing’s host
  - `accommodates`: Listing’s maximum number of occupants
  - `bedrooms`: Number of bedrooms in the listing
  - `description`: Description of the listing on Airbnb

- **reviews table**
  - `id`: ID of the review
  - `listing_id`: ID of the listing which received the review
  - `date`: Date the review was posted
  - `reviewer_name`: Airbnb username of the reviewer
  - `comments`: Content of the review

- **availabilities table**
  - `id`: ID of the availability
  - `listing_id`: Listing ID associated with the availability
  - `date`: Date of the availability
  - `available`: Whether the date is still available to be booked (TRUE or FALSE)
  - `price`: Price of staying on the given date



## Specification and queries

### No Descriptions
You might notice that when running `SELECT * FROM "listings" LIMIT 5;` 
the results look quite wonky! The description column contains descriptions with many line breaks, each of which are printed to your terminal.

In no_descriptions.sql, write a SQL statement to create a view named no_descriptions that includes all of the columns in the listings table except for description.
```
CREATE VIEW no_descriptions AS
SELECT id,
    property_type,
    host_name,
    accommodates,
    bedrooms
FROM listings;
```

### One-Bedrooms
In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms. This view should contain all listings that have exactly one bedroom. Ensure the view contains the following columns:

- id, which is the id of the listing from the listings table.
- property_type, from the listings table.
- host_name, from the listings table.
- accommodates, from the listings table.
```
CREATE VIEW one_bedrooms AS
SELECT id,
    property_type,
    host_name,
    accommodates
FROM listings
WHERE bedrooms = 1;
```

### Available
In available.sql, write a SQL statement to create a view named available. This view should contain all dates that are available at all listings. Ensure the view contains the following columns:

- id, which is the id of the listing from the listings table.
- property_type, from the listings table.
- host_name, from the listings table.
- date, from the availabilities table, which is the date of the availability.
```
CREATE VIEW available AS
SELECT listings.id,
    property_type,
    host_name,
    date
FROM listings JOIN availabilities
    ON listings.id = availabilities.listing_id
WHERE available = 'TRUE';
```

### Frequently Reviewed
In frequently_reviewed.sql, write a SQL statement to create a view named frequently_reviewed. This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed. Ensure the view contains the following columns:

- id, which is the id of the listing from the listings table.
- property_type, from the listings table.
- host_name, from the listings table.
- reviews, which is the number of reviews the listing has received.

If any two listings have the same number of reviews, sort by property_type (in alphabetical order), followed by host_name (in alphabetical order).
```
CREATE VIEW frequently_reviewed AS
SELECT listings.id,
    property_type,
    host_name,
    COUNT(reviews.id) reviews
FROM listings JOIN reviews
    ON reviews.listing_id = listings.id
GROUP BY listings.id
ORDER BY reviews DESC,
    property_type,
    host_name
LIMIT 100;
```

### June Vacancies
In june_vacancies.sql, write a SQL statement to create a view named june_vacancies. This view should contain all listings and the number of days in June of 2023 that they remained vacant. Ensure the view contains the following columns:

- id, which is the id of the listing from the listings table.
- property_type, from the listings table.
- host_name, from the listings table.
- days_vacant, which is the number of days in June of 2023, that the given listing was marked as available.
```
CREATE VIEW june_vacancies AS
SELECT listings.id,
    property_type,
    host_name,
    COUNT(availabilities.id) days_vacant
FROM listings JOIN availabilities
    ON listings.id = availabilities.listing_id
WHERE strftime('%Y-%m', availabilities.date) = '2023-06'
    AND availabilities.available = 'TRUE'
GROUP BY listings.id;
```
