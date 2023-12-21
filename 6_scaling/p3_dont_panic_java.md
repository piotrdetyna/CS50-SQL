# Don’t Panic! (Sentimental) with Python problem

The "Don’t Panic!" assignment in CS50's Introduction to Databases with SQL, Java version, puts students in the role of a pentester hired to test and report vulnerabilities in a company's data system. Students are tasked with automating their hack by writing a Java program. The main objectives include connecting to a SQLite database (dont-panic.db) using Java and altering the administrator’s password within the Java program.

See full problem: [https://cs50.harvard.edu/sql/2023/psets/6/dont-panic/java/](https://cs50.harvard.edu/sql/2023/psets/6/dont-panic/java/)

<img src="https://piotr.detyna.pl/cs50-sql/week-6/dont-panic.jpg" alt="connect" style="width: 50%">

## Specification and solution

You’re a trained “pentester.” After your success in an earlier operation, a new company has hired you to perform a penetration test and report the vulnerabilities in their data system. This time, you suspect you can do better by writing a program in Java that automates your hack.

To succeed in this covert operation, you’ll need to…

- Connect, via Java, to a SQLite database.
- Alter, within your Java program, the administrator’s password.

```
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

public class Hack {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the new password: ");
        String password = scanner.nextLine();

        Connection sqliteConnection = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");

        String query = """
            UPDATE "users"
            SET "password" = ?
            WHERE "username" = 'admin';
        """;
        PreparedStatement sqliteStatement = sqliteConnection.prepareStatement(query);
        sqliteStatement.setString(1, password);

        sqliteStatement.executeUpdate();

        sqliteConnection.close();
        scanner.close();
    }
}
```