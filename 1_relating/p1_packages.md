# Packages, Please problem
The "Packages, Please" assignment in CS50's Introduction to Databases with SQL simulates the role of a mail clerk in Boston, responsible for solving mysteries related to missing packages. Using the database packages.db, students must determine the current location, address type, and contents of each missing package based on customer reports. 

The database encompasses entities such as drivers, packages, addresses, and package scans, with tables like addresses, drivers, packages, and scans that store relevant data.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/1/packages/](https://cs50.harvard.edu/sql/2023/psets/1/packages/)

<img src="https://piotr.detyna.pl/cs50-sql/week-1/packages.png" alt="packages" style="width: 50%">

## Schema
- **addresses table**
  - `id`: ID of the address
  - `address`: Street address (e.g., 7660 Sharon Street)
  - `type`: Type of address (e.g., residential, commercial)

- **drivers table**
  - `id`: ID of the driver
  - `name`: First name of the driver

- **packages table**
  - `id`: ID of the package
  - `contents`: Contents of the package
  - `from_address_id`: ID of the address from which the package was sent
  - `to_address_id`: ID of the address to which the package was sent

- **scans table**
  - `id`: ID of the scan
  - `driver_id`: ID of the driver who created the scan
  - `package_id`: ID of the package scanned
  - `address_id`: ID of the address where the package was scanned
  - `action`: Indicates whether the package was picked up (“Pick”) or dropped off (“Drop”)
  - `timestamp`: Day and time at which the package was scanned


## Specification and my solutions
### The Lost Letter
Your first report of a missing package comes from Anneke. Anneke walks up to your counter and tells you the following:

_Clerk, my name’s Anneke. I live over at 900 Somerville Avenue. Not long ago, I sent out a special letter. It’s meant for my friend Varsha. She’s starting a new chapter of her life at 2 Finnegan Street, uptown. (That address, let me tell you: it was a bit tricky to get right the first time.) The letter is a congratulatory note—a cheery little paper hug from me to her, to celebrate this big move of hers. Can you check if it’s made its way to her yet?_

**Questions & answers:** 
- At what type of address did the Lost Letter end up?: **Residential**
- At what address did the Lost Letter end up?: **2 Finnigan Street**
  

**Queries:**

```
-- Find sender's address
    SELECT * FROM addresses 
    WHERE address = '900 Somerville Avenue';
    +-----+-----------------------+-------------+
    | id  |        address        |    type     |
    +-----+-----------------------+-------------+
    | 432 | 900 Somerville Avenue | Residential |
    +-----+-----------------------+-------------+

-- Get all packages sent from this address:
    SELECT * FROM packages 
    WHERE from_address_id = 432;
    +------+-----------------------+-----------------+---------------+
    |  id  |       contents        | from_address_id | to_address_id |
    +------+-----------------------+-----------------+---------------+
    | 384  | Congratulatory letter | 432             | 854           |
    | 2437 | String                | 432             | 484           |
    | 3529 | Letter opener         | 432             | 585           |
    | 5436 | Whiteboard            | 432             | 4984          |
    +------+-----------------------+-----------------+---------------+
-- From this output we could assume the lost letter is package with id 384, but just to be sure, we will check recipient address to see if it is similar to "2 Finnegan Street"

    SELECT * FROM addresses WHERE id = 854;
    +-----+-------------------+-------------+
    | id  |      address      |    type     |
    +-----+-------------------+-------------+
    | 854 | 2 Finnigan Street | Residential |
    +-----+-------------------+-------------+

-- Answer to question 1: At what type of address did the Lost Letter end up?: Residential
    SELECT addresses.type
    FROM scans JOIN addresses
        ON scans.address_id = addresses.id
    WHERE package_id = 384
    ORDER BY scans.id DESC
    LIMIT 1;
    +-------------+
    |    type     |
    +-------------+
    | Residential |
    +-------------+

-- Answer to question 2: At what address did the Lost Letter end up?: 2 Finnigan Street
    SELECT addresses.address
    FROM scans JOIN addresses
        ON scans.address_id = addresses.id
    WHERE package_id = 384
    ORDER BY scans.id DESC
    LIMIT 1;

    +-------------------+
    |      address      |
    +-------------------+
    | 2 Finnigan Street |
    +-------------------+
```

### The Devious Delivery
Your second report of a missing package comes from a mysterious fellow from out of town. They walk up to your counter and tell you the following:

_Good day to you, deliverer of the mail. You might remember that not too long ago I made my way over from the town of Fiftyville. I gave a certain box into your reliable hands and asked you to keep things low. My associate has been expecting the package for a while now. And yet, it appears to have grown wings and flown away. Ha! Any chance you could help clarify this mystery? Afraid there’s no “From” address. It’s the kind of parcel that would add a bit more… quack to someone’s bath times, if you catch my drift._

**Questions & answers:** 
- At what type of address did the Devious Delivery end up?: **Police Station**
- What were the contents of the Devious Delivery?: **Duck debugger**

**Queries:**
```
-- find package without from_address_id
    SELECT * FROM packages 
    WHERE from_address_id IS NULL;
    +------+---------------+-----------------+---------------+
    |  id  |   contents    | from_address_id | to_address_id |
    +------+---------------+-----------------+---------------+
    | 5098 | Duck debugger |                 | 50            |
    +------+---------------+-----------------+---------------+
-- So we can answer to the question: What were the contents of the Devious Delivery?: Duck debugger

-- Answer to the question: At what type of address did the Devious Delivery end up?: Police Station
    SELECT addresses.type
    FROM scans JOIN addresses
        ON scans.address_id = addresses.id
    WHERE package_id = 5098
    ORDER BY scans.id DESC
    LIMIT 1;
```

### The Forgotten Gift

Your third report of a missing package comes from a grandparent who lives down the street from the post office. They approach your counter and tell you the following:

_Oh, excuse me, Clerk. I had sent a mystery gift, you see, to my wonderful granddaughter, off at 728 Maple Place. That was about two weeks ago. Now the delivery date has passed by seven whole days and I hear she still waits, her hands empty and heart filled with anticipation. I’m a bit worried wondering where my package has gone. I cannot for the life of me remember what’s inside, but I do know it’s filled to the brim with my love for her. Can we possibly track it down so it can fill her day with joy? I did send it from my home at 109 Tileston Street._

**Questions & answers:** 
- What are the contents of the Forgotten Gift?: **Flowers**
- Who has the Forgotten Gift?: **Mikel**


**Queries:**
```
-- Find package
SELECT *
FROM packages JOIN addresses from_addresses
    ON packages.from_address_id = from_addresses.id
JOIN addresses to_addresses
    ON packages.to_address_id = to_addresses.id
WHERE from_addresses.address = '109 Tileston Street'
    AND to_addresses.address = '728 Maple Place';

+------+----------+-----------------+---------------+------+---------------------+-------------+------+-----------------+-------------+
|  id  | contents | from_address_id | to_address_id |  id  |       address       |    type     |  id  |     address     |    type     |
+------+----------+-----------------+---------------+------+---------------------+-------------+------+-----------------+-------------+
| 9523 | Flowers  | 9873            | 4983          | 9873 | 109 Tileston Street | Residential | 4983 | 728 Maple Place | Residential |
+------+----------+-----------------+---------------+------+---------------------+-------------+------+-----------------+-------------+

-- Find the driver
SELECT * 
FROM scans JOIN drivers 
    ON drivers.id = scans.driver_id
WHERE package_id = 9523
ORDER BY timestamp DESC
LIMIT 1;

+-------+-----------+------------+------------+--------+----------------------------+----+-------+
|  id   | driver_id | package_id | address_id | action |         timestamp          | id | name  |
+-------+-----------+------------+------------+--------+----------------------------+----+-------+
| 12432 | 17        | 9523       | 7432       | Pick   | 2023-08-23 19:41:47.913410 | 17 | Mikel |
+-------+-----------+------------+------------+--------+----------------------------+----+-------+
```