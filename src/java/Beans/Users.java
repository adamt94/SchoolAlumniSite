/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Package.DatabaseAccess;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;

/**
 *
 * @author Stuart
 */
public class Users {

    //database variables
    private String username;
    private String password;
    private String first_name;
    private String last_name;
    private String description;
    private boolean isAdmin;
    //other variables
    private ArrayList<Enrolment> enrolments;

    //default constructor
    public Users() {
    }

    public Users(String user) {

        /*
         =============NOTE============
        
         Make sure to come back and validate these at some point, with appropriate
         exceptions thrown and errors handled.
         */
        this.username = user;
        populateUser(this.username);
    }

    public Users(ResultSet rs) throws SQLException {

        /*
         =============NOTE============
        
         Make sure to come back and validate these at some point, with appropriate
         exceptions thrown and errors handled.
         */
        this.username = rs.getString("user_name");
        this.first_name = rs.getString("first_name");
        this.last_name = rs.getString("last_name");
        this.description = rs.getString("description");
        populateUser(this.username);
    }

    public Users(String user, String pass) {

        /*
         =============NOTE============
        
         Make sure to come back and validate these at some point, with appropriate
         exceptions thrown and errors handled.
         */
        this.username = user;
        this.password = pass;
        populateUser(this.username);
        //getEnrolments();
    }

    public Users(String user, String pass, String firstName, String lastName, String desc) {

        /*
         =============NOTE============
        
         Make sure to come back and validate these at some point, with appropriate
         exceptions thrown and errors handled.
         */
        this.username = user;
        this.password = pass;
        this.first_name = firstName;
        this.last_name = lastName;
        this.description = desc;
    }

    //accessor methods
    public String getUsername() {
        return this.username;
    }

    public String getPassword() {
        return this.password;
    }

    public String getFirstName() {
        return this.first_name;
    }

    public String getLastName() {
        return this.last_name;
    }

    public String getDescription() {
        return this.description;
    }
    
    public boolean isAdmin() {
        return this.isAdmin;
    }

    //mutator methods
    public void setUsername(String givenUsername) {
        //make sure to validate this at some point
        this.username = givenUsername;
    }

    public void setPassword(String givenPassword) {
        this.password = givenPassword;
    }

    public void setFirstName(String givenName) {
        this.first_name = givenName;
    }

    public void setLastName(String givenName) {
        this.last_name = givenName;
    }

    public void setDescription(String givenDesc) {
        this.description = givenDesc;
    }

    //Populate object with details of user using their username
    private boolean populateUser(String usr) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM users"
                    + " WHERE user_name = '" + usr + "';";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            if (rs.next()) {
                this.description = rs.getString("description");
                this.first_name = rs.getString("first_name");
                this.last_name = rs.getString("last_name");
                this.isAdmin = rs.getBoolean("isAdmin");
            }
            return true;
        } catch (SQLException ex) {
            System.out.println("User class error: " + ex);
            return false;
        } catch (ServletException ex) {
            System.out.println("User class error:" + ex);
            return false;
        }
    }

    //get schoolmates of user
    public static ArrayList Schoolmates(String userName) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            ArrayList<Enrolment> enrolments = Enrolment.getEnrolments(userName);
            ArrayList<Users> schoolmates = new ArrayList();
            String sql;
            ResultSet rs;
            boolean valid;
            for (Enrolment e : enrolments) {
                sql = "SELECT DISTINCT users.* FROM users\n"
                        + "INNER JOIN enrolment ON (enrolment.user_name = users.user_name)\n"
                        + "WHERE (enrolment.start_year <= " + e.getEndYear() + ") AND ( " + e.getStartYear() + " <= enrolment.end_year) \n"
                        + "AND enrolment.school_id = '" + e.getSchoolID() + "' AND enrolment.user_name <> '" + userName + "'";
                rs = database.runQuery(sql, database.getConnection());
                while (rs.next()) {
                    valid = true;
                    Users schoolmate = new Users(rs.getString("user_name"));
                    for (Users u : schoolmates) {//check to see user isnt already in the schoolmates list
                        if (u.getUsername().equals(rs.getString("user_name"))) {
                            valid = false;
                        }
                    }
                    if (valid) {//if the list doesnt already have this schoolmate
                        schoolmates.add(schoolmate);
                    } else {

                    }
                }
            }
            return schoolmates;
        } catch (ServletException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NullPointerException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean isValid() {
        DatabaseAccess database = new DatabaseAccess();
        ResultSet rs;
        try {
            rs = database.runQuery("SELECT user_name,password FROM users\n"
                    + "WHERE user_name = '" + this.username
                    + "' AND password ='" + this.password + "'",
                    database.getConnection());
            if (rs.first()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
        } catch (ServletException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //add the user object to the database
    public boolean persistUser() {
        try {
            String sql;
            DatabaseAccess database;
            database = new DatabaseAccess();
            sql = "INSERT INTO users(user_name, password, first_name, last_name, description) "
                    + "VALUES('" + this.username + "', '" + this.password + "', '"
                    + this.first_name + "', '" + this.last_name + "', '" + this.description + "');";
            database.runUpdateQuery(sql, database.getConnection());
            database = new DatabaseAccess();
            sql = "INSERT INTO image(user_name) "
                    + "VALUES('" + this.username + "');";
            database.runUpdateQuery(sql, database.getConnection());
            return true;
        } catch (ServletException ex) {
            return false;
        }
    }

    static public boolean isExisting(String givenUsername) {
        DatabaseAccess database = new DatabaseAccess();
        ResultSet rs;
        try {
            rs = database.runQuery("SELECT user_name FROM users\n"
                    + "WHERE user_name = '" + givenUsername + "'",
                    database.getConnection());
            if (rs.first()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException ex) {
        } catch (ServletException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //update existing user with current Users object details
    public boolean updateUser() {
        if (isValid()) {
            try {
                String sql;
                DatabaseAccess database;
                database = new DatabaseAccess();
                sql = "UPDATE users \n"
                        + "SET first_name='" + this.first_name + "', last_name='" + this.last_name + "', description='" + this.description + "'\n"
                        + "WHERE user_name = '" + this.username + "';";
                database.runUpdateQuery(sql, database.getConnection());
                return true;
            } catch (ServletException ex) {
                return false;

            }
        } else {
            //throw new InvalidUserException(); NEEDS TO BE IMPLEMENTED
            return false;
        }
    }

    public static int numberOfUsers() {
        DatabaseAccess database = new DatabaseAccess();
        ResultSet rs;
        try {
            rs = database.runQuery("SELECT COUNT(user_name) AS NumberOfUsers FROM users",database.getConnection());
            if (rs.first()) {
                return rs.getInt("NumberOfUsers");
            } else {
                return -1;
            }
        } catch (SQLException ex) {
        } catch (ServletException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public static ArrayList<Users> getAllUsers(){
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM users";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            ArrayList users = new ArrayList();
            while(rs.next()) {
                users.add(new Users(rs));
            }
            return users;
        } catch (SQLException ex) {
            System.out.println("School class error: " + ex);
            return null;
        } catch (ServletException ex) {
            System.out.println("School class error:" + ex);
            return null;
        }
    }
}
