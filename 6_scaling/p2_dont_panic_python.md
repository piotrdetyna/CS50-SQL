# Don’t Panic! (Sentimental) with Python problem

The "Don’t Panic!" assignment in CS50's Introduction to Databases with SQL involves a scenario where students, as trained penetration testers, are hired to assess and report vulnerabilities in a data system. This iteration of the assignment requires writing a Python program to automate the hacking process. 

The key tasks are to connect to a SQLite database (dont-panic.db) using Python and alter the administrator’s password within the Python program. Students will use the CS50 library for Python to establish the database connection and execute the necessary SQL commands to change the administrator’s password

See full problem: [https://cs50.harvard.edu/sql/2023/psets/6/dont-panic/python/](https://cs50.harvard.edu/sql/2023/psets/6/dont-panic/python/)

<img src="https://piotr.detyna.pl/cs50-sql/week-6/dont-panic.jpg" alt="connect" style="width: 50%">

## Specification and solution

You’re a trained “pentester.” After your success in an earlier operation, a new company has hired you to perform a penetration test and report the vulnerabilities in their data system. This time, you suspect you can do better by writing a program in Python that automates your hack.

To succeed in this covert operation, you’ll need to…

- Connect, via Python, to a SQLite database.
- Alter, within your Python program, the administrator’s password.

```
from cs50 import SQL
db = SQL("sqlite:///dont-panic.db")
new_admin_password = input("Enter a password: ")

db.execute('''
    UPDATE users
    SET password = ?
    WHERE username = 'admin';
''', new_admin_password)

```