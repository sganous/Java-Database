/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
 */
package jdbcproject;

import java.sql.*;
import java.util.*;

/**
 *
 *
 *
 * @author phannachrin
 *
 */
public class JDBCProject {
// Database credentials/

    static String USER;
    static String PASS;
    static String DBNAME;
//This is the specification for the printout that I'm doing:
//each % denotes the start of a new field.
//The - denotes left justification.
//The number indicates how wide to make the field.
//The "s" denotes that it's a string. All of our output in this test are
//strings, but that won't always be the case.
    static final String displayFormat = "%-25s%-35s%-25s%-25s\n";
    static final String displayFormat2 = "%-25s%-25s%-25s%-25s%-15s\n";
// JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.apache.derby.jdbc.ClientDriver";
    static String DB_URL = "jdbc:derby://localhost:1527/";
// + "testdb;user=";

    /**
     *
     * Takes the input string and outputs "N/A" if the string is empty or null.
     *
     * @param input The string to be mapped.
     *
     * @return Either the input string or "N/A" as appropriate.
     *
     */
    public static String dispNull(String input) {
//because of short circuiting, if it's null, it never checks the length.
        if (input == null || input.length() == 0) {
            return "N/A";
        } else {
            return input;
        }
    }

    /**
     *
     * @param args the command line arguments
     *
     */
    public static void main(String[] args) {
// TODO code application logic here
//Prompt the user for the database name, and the credentials.
//If your database has no credentials, you can update this code to
//remove that from the connection string.
        Scanner in = new Scanner(System.in);
        Scanner in2 = new Scanner(System.in);
        int choice = 0;
        int choice2 = 0;
        System.out.print("Name of the database (not the user account): ");
        DBNAME = in.nextLine();
        System.out.print("Database user name: ");
        USER = in.nextLine();
        System.out.print("Database password: ");
        PASS = in.nextLine();
//Constructing the database URL connection string
        DB_URL = DB_URL + DBNAME + ";user=" + USER + ";password=" + PASS;
        Connection conn = null; //initialize the connection
        Statement stmt = null; //initialize the statement that we're using

        ResultSet rs = null;
        PreparedStatement pstmt = null;
//PreparedStatement pstmt = null;
        try {
//STEP 2: Register JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
//STEP 3: Open a connection
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL);
//STEP 4: Execute a query
//EXTERNAL LOOP1
            while (choice != 4) {
                System.out.println("Which table would you like to access? ");
                System.out.println("Press '1' for WritingGroup.");
                System.out.println("Press '2' for Publisher.");
                System.out.println("Press '3' for Book.");
                System.out.println("Press '4' to Exit.");
                choice = in2.nextInt();
//User choose writing_group table
                while (choice == 1) {
                    System.out.println("writing_group Query: ");
                    System.out.println("1:List all writing group.");
                    System.out.println("2:Choose specific writing group.");
                    System.out.println("3:Go Back.");
                    choice2 = in2.nextInt();
                    if (choice2 == 1) {
//System.out.println("Creating statement...");
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM writing_group";
                        rs = stmt.executeQuery(sql);
//Display result
                        System.out.printf(displayFormat, "group_name", "head_writer",
                                "year_formed", "subject");
                        while (rs.next()) {
                            String name = rs.getString("group_name");
                            String writer = rs.getString("head_writer");
                            String year = rs.getString("year_formed");
                            String subject = rs.getString("subject");
                            System.out.printf(displayFormat,
                                    dispNull(name), dispNull(writer), dispNull(year), dispNull(subject));
                        }
                    } else if (choice2 == 2) {
                        String query;
                        System.out.println("Enter query:");
                        query = in.nextLine();
                        String sql = "SELECT * FROM writing_group "
                                + "WHERE group_name = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, query);
                        rs = pstmt.executeQuery();
                        //VALIDATE RESULT SET
                        if (!rs.next()) {
                            System.out.println("Value " + query + " does not exist in the database.");
                            continue;
                        }
                        rs = pstmt.executeQuery();
                        System.out.printf(displayFormat, "group_name", "head_writer",
                                "year_formed", "subject");
//Display result
                        while (rs.next()) {
                            String name = rs.getString("group_name");
                            String writer = rs.getString("head_writer");
                            String year = rs.getString("year_formed");
                            String subject = rs.getString("subject");
                            System.out.printf(displayFormat,
                                    dispNull(name), dispNull(writer), dispNull(year), dispNull(subject));
                        }
                    } else if (choice2 == 3) {
                        break;
                    }
                }
//User choose publisher table
                while (choice == 2) {
                    System.out.println("publisher Query: ");
                    System.out.println("1:List all publisher group.");
                    System.out.println("2:List specified data.");
                    System.out.println("3:Insert a new publisher");
                    System.out.println("4:Replace Publisher");
                    System.out.println("5:Go Back.");
                    choice2 = in2.nextInt();
                    if (choice2 == 1) {
//System.out.println("Creating statement...");
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM publisher";
                        rs = stmt.executeQuery(sql);
//Display result
                        System.out.printf(displayFormat, "publisher_name",
                                "publisher_address", "publisher_phone", "publisher_email");
                        while (rs.next()) {
                            String name = rs.getString("publisher_name");
                            String address = rs.getString("publisher_address");
                            String phone = rs.getString("publisher_phone");
                            String email = rs.getString("publisher_email");
                            System.out.printf(displayFormat,
                                    dispNull(name), dispNull(address), dispNull(phone), dispNull(email));
                        }
                    } else if (choice2 == 2) {
                        String query;
                        System.out.println("Enter query:");
                        query = in.nextLine();
                        String sql = "SELECT * FROM publisher "
                                + "WHERE publisher_name = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, query);
                        rs = pstmt.executeQuery();
                        //VALIDATE RESULT SET
                        if (!rs.next()) {
                            System.out.println("Value " + query + " does not exist in the database.");
                            continue;
                        }
                        rs = pstmt.executeQuery();
//Display result
                        System.out.printf(displayFormat, "publisher_name",
                                "publisher_address", "publisher_phone", "publisher_email");
                        while (rs.next()) {
                            String name = rs.getString("publisher_name");
                            String address = rs.getString("publisher_address");
                            String phone = rs.getString("publisher_phone");
                            String email = rs.getString("publisher_email");
                            System.out.printf(displayFormat,
                                    dispNull(name), dispNull(address), dispNull(phone), dispNull(email));
                        }
                    } else if (choice2 == 3) {
                        String pubName, pubName2, pubAddress, pubPhone, pubEmail, sql, sql2;
                        System.out.println("Enter publisher name: ");
                        pubName = in.nextLine();
                        System.out.println("Enter publisher address: ");
                        pubAddress = in.nextLine();
                        System.out.println("Enter publisher phone number: ");
                        pubPhone = in.nextLine();
                        System.out.println("Enter publisher email: ");
                        pubEmail = in.nextLine();
                        sql = "INSERT INTO Publisher VALUES(?,?,?,?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, pubName);
                        pstmt.setString(2, pubAddress);
                        pstmt.setString(3, pubPhone);
                        pstmt.setString(4, pubEmail);
                        pstmt.executeUpdate();
                    } else if (choice2 == 4) {
                        String pubName, pubName2, sql;
                        System.out.println("Enter publisher name to replace: ");
                        pubName = in.nextLine();
                        System.out.println("Enter new publisher name: ");
                        pubName2 = in.nextLine();
                        sql = "UPDATE book SET publisher_name = ? WHERE publisher_name = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, pubName2);
                        pstmt.setString(2, pubName);
                        pstmt.executeUpdate();
                    } else if (choice2 == 5) {
                        break;
                    }
                }
//User choose to access book table
                while (choice == 3) {
                    System.out.println("book Query: ");
                    System.out.println("1:List all book group.");
                    System.out.println("2:List specified data.");
                    System.out.println("3:Insert new a new book.");
                    System.out.println("4:Remove a book.");
                    System.out.println("5:Go Back.");
                    choice2 = in2.nextInt();
                    if (choice2 == 1) {
//System.out.println("Creating statement...");
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM book";
                        rs = stmt.executeQuery(sql);
//Display result
                        System.out.printf(displayFormat2, "goup_name",
                                "book_title", "publisher_name", "year_published", "number_pages");
                        while (rs.next()) {
                            String gName = rs.getString("group_name");
                            String book = rs.getString("book_title");
                            String pName = rs.getString("publisher_name");
                            String year = rs.getString("year_published");
                            String page = rs.getString("number_pages");
                            System.out.printf(displayFormat2,
                                    dispNull(gName), dispNull(book), dispNull(pName), dispNull(year),
                                    dispNull(page));
                        }
                    } else if (choice2 == 2) {
                        String query;
                        System.out.println("Enter name of book you want to view:");
                        query = in.nextLine();
                        String sql = "SELECT * FROM book "
                                + "WHERE book_title = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, query);
                        rs = pstmt.executeQuery();

                        //VALIDATE RESULT SET
                        if (!rs.next()) {
                            System.out.println("Value " + query + " does not exist in the database.");
                            continue;
                        }
                        rs = pstmt.executeQuery();
//Display result
                        System.out.printf(displayFormat2, "goup_name",
                                "book_title", "publisher_name", "year_published", "number_pages");
                        while (rs.next()) {
                            String gName = rs.getString("group_name");
                            String book = rs.getString("book_title");
                            String pName = rs.getString("publisher_name");
                            String year = rs.getString("year_published");
                            String page = rs.getString("number_pages");
                            System.out.printf(displayFormat2,
                                    dispNull(gName), dispNull(book), dispNull(pName), dispNull(year),
                                    dispNull(page));
                        }
                    } else if (choice2 == 3) {
                        String gName, title, pName, year, page, sql;
                        System.out.println("Enter group name: ");
                        gName = in.nextLine();
                        System.out.println("Enter the title of the book: ");
                        title = in.nextLine();
                        System.out.println("Enter publisher name: ");
                        pName = in.nextLine();
                        System.out.println("Enter the year the book was published: ");
                        year = in.nextLine();
                        System.out.println("Enter the number of pages: ");
                        page = in.nextLine();
                        sql = "INSERT INTO book VALUES(?,?,?,?,?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, gName);
                        pstmt.setString(2, pName);
                        pstmt.setString(3, title);
                        pstmt.setString(4, year);
                        pstmt.setString(5, page);
                        pstmt.executeUpdate();
                    } else if (choice2 == 4) {
                        String query;
                        System.out.println("Enter name of book you want to remove:");
                        query = in.nextLine();
                        String sql = "SELECT * FROM book "
                                + "WHERE book_title = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, query);
                        rs = pstmt.executeQuery();
                        if (!rs.next()) {
                            System.out.println("The value "+query+" does not exist in the databse.");
                            continue;
                        }
                        sql = "DELETE FROM book WHERE book_title = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.clearParameters();
                        pstmt.setString(1, query);
                        pstmt.executeUpdate();
                    } else if (choice2 == 5) {
                        break;
                    }
                }
            }
//STEP 6: Clean-up environment
            rs.close();
            stmt.close();
            pstmt.close();
            conn.close();
        } catch (SQLException se) {
//Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
//Handle errors for Class.forName
            e.printStackTrace();
        } finally {
//finally block used to close resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException se2) {
            }// nothing we can do
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
        System.out.println("Goodbye!");
    }//end main
}



