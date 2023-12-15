# Union Square Donuts problem

The "Union Square Donuts" assignment in CS50's Introduction to Databases with SQL involves designing a database for Union Square Donuts. Students must create this database from scratch, using CREATE TABLE statements in a schema.sql file. 

The database is required to manage various aspects of the donut shop's operations, including tracking ingredients and their prices, details of donuts (name, gluten-free status, price), recording online orders (order numbers, donuts ordered, and customer information), and maintaining customer data (names and order history). The focus is on fulfilling the shop's operational needs and representing sample data provided in the assignment.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/2/donuts/](https://cs50.harvard.edu/sql/2023/psets/2/donuts/)

<img src="https://piotr.detyna.pl/cs50-sql/week-2/donuts.png" alt="Donuts" style="width: 50%">

## Specification and schema

### Ingredients
We certainly need to keep track of our ingredients. Some of the typical ingredients we use include flour, yeast, oil, butter, and several different types of sugar. Moreover, we would love to keep track of the price we pay per unit of ingredient (whether it’s pounds, grams, etc.).
```
CREATE TABLE ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ingredient TEXT NOT NULL UNIQUE CHECK(length(ingredient) BETWEEN 1 AND 100),
    price REAL CHECK(price > 0)
);
```

### Donuts
We’ll need to include our selection of donuts, past and present! For each donut on the menu, we’d love to include three things:
- The name of the donut
- Whether the donut is gluten-free
- The price per donut

Note: Oh, and it’s important that we be able to look up the ingredients for each of the donuts!
```
CREATE TABLE donuts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 100),
    is_gluten_free INTEGER DEFAULT 0 CHECK(is_gluten_free BETWEEN 0 AND 1),
    price REAL NOT NULL CHECK(price > 0)
);

CREATE TABLE donut_ingredients (
    donut_id INTEGER,
    ingredient_id INTEGER,
    quantity NUMERIC,
    FOREIGN KEY (donut_id) REFERENCES donuts(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE RESTRICT
);

```
### Orders
We love to see customers in person, though we realize a good number of people might order online nowadays. We’d love to be able to keep track of those online orders. We think we would need to store:
- An order number, to keep track of each order internally
- All the donuts in the order
- The customer who placed the order. We suppose we could assume only one customer places any given order.
```
CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE order_donuts (
    order_id INTEGER,
    donut_id INTEGER,
    FOREIGN KEY (donut_id) REFERENCES donuts(id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

```

### Customers
Oh, and we realize it would be lovely to keep track of some information about each of our customers. We’d love to remember the history of the orders they’ve made. In that case, we think we should store:
- A customer’s first and last name
- A history of their orders
```
CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 100),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 100)
);
```


## Full schema
```
CREATE TABLE ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ingredient TEXT NOT NULL UNIQUE CHECK(length(ingredient) BETWEEN 1 AND 100),
    price REAL CHECK(price > 0)
);

CREATE TABLE donuts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 100),
    is_gluten_free INTEGER DEFAULT 0 CHECK(is_gluten_free BETWEEN 0 AND 1),
    price REAL NOT NULL CHECK(price > 0)
);

CREATE TABLE donut_ingredients (
    donut_id INTEGER,
    ingredient_id INTEGER,
    quantity NUMERIC,
    FOREIGN KEY (donut_id) REFERENCES donuts(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
);

CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL CHECK(length(first_name) BETWEEN 1 AND 100),
    last_name TEXT NOT NULL CHECK(length(last_name) BETWEEN 1 AND 100)
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);


CREATE TABLE order_donuts (
    order_id INTEGER,
    donut_id INTEGER,
    FOREIGN KEY (donut_id) REFERENCES donuts(id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);


```