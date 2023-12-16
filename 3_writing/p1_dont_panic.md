# Don’t Panic! problem

The "Don't Panic!" assignment in CS50's Introduction to Databases with SQL casts students in the role of a "pentester" (penetration tester) tasked with testing the security of a SQLite database that powers a website. 

The assignment involves a series of covert operations, including altering the administrative account's password, erasing any logs of this password change, and adding false data to mislead the company. Students must download the dont-panic.zip file, which includes the dont-panic.db database and hack.sql and reset.sql files. The challenge is to write SQL statements in hack.sql to accomplish these tasks, keeping in mind that passwords in the database are stored as MD5 hashes.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/3/dont-panic/](https://cs50.harvard.edu/sql/2023/psets/3/dont-panic/)

<img src="https://piotr.detyna.pl/cs50-sql/week-3/dont-panic.png" alt="Don't Panic" style="width: 50%">

## Specification and queries

In hack.sql, write a sequence of SQL statements to achieve the following:

- Alter the password of the website’s administrative account, admin, to instead be “oops!”.
- Erase any logs of the above password change recorded by the database.
- Add false data to throw others off your trail. In particular, to frame emily33, make it only appear—in the user_logs table—as if the admin account has had its password changed to emily33’s password.


When your SQL statements in hack.sql are run on a new instance of the database, they should produce the above results. Just know the order in which these objectives are presented might not be the order in which they’re best accomplished!

Also keep in mind that passwords are usually not stored “in the clear”—that is, as the plain characters that make up the password. Instead they’re “hashed,” or scrambled, to preserve privacy. Given this reality, you’ll need to ensure the password to which you change the administrative password is also hashed. Thankfully, you know that the passwords in the users table are already stored as MD5 hashes. You can generate quickly generate such hashes from plaintext at md5hashgenerator.com.

```
UPDATE users
SET password = '982c0381c279d139fd221fce974916e7' -- 'oops!'
WHERE username = 'admin';

UPDATE user_logs
SET new_password = (
    SELECT password
    FROM users
    WHERE username = 'emily33'
)
WHERE id = (SELECT MAX(id) FROM user_logs) -- latest log
```