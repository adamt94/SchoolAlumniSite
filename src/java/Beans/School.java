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
public class School {
    private int school_id;
    private String name;
    private String description;
    private String website;
    
 
    //default constructor
    public School(){}
    
    public School(int id){
        this.school_id = id;
        populateSchool(id);
    }
    
    public School(String givenName, String givenDesc, String givenSite){
        this.name = givenName;
        this.description = givenDesc;
        this.website = givenSite;
    }
    
    public School(ResultSet rs) throws SQLException{
        this.school_id = rs.getInt("school_id");
        this.name = rs.getString("name");
        this.description = rs.getString("description");
        this.website = rs.getString("website");
    }
    
    private boolean populateSchool(int id) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM school"
                    + " WHERE school_id = '" + id + "';";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            if (rs.next()) {
                this.description = rs.getString("description");
                this.name = rs.getString("name");
                this.website = rs.getString("website");
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
    
    //accessor methods
    public int getSchoolID(){
        return this.school_id;
    }
    public String getName(){
        return this.name;
    }
    public String getDescription(){
        return this.description;
    }
    public String getWebsite(){
        return this.website;
    }
    
    //mutator methods
    public void setSchoolID(int given){
        this.school_id = given;
    }
    public void setName(String given){
        this.name = given;
    }
    public void setDescription(String given){
        this.description = given;
    }
    public void setWebsite(String given){
        this.website = given;
    }
    
    //other methods
    public static ArrayList getAllSchools(){
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM school";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            ArrayList schools = new ArrayList();
            while(rs.next()) {
                schools.add(new School(rs));
            }
            return schools;
        } catch (SQLException ex) {
            System.out.println("Enrolment class error: " + ex);
            return null;
        } catch (ServletException ex) {
            System.out.println("Enrolment class error:" + ex);
            return null;
        }
    }
    
    public static String[] getSchoolNames(){
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT name FROM school";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            ArrayList<String> schools = new ArrayList();
            while(rs.next()) {
                schools.add(rs.getString("name"));
            }
            String[] nameArray = new String[schools.size()];
            schools.toArray(nameArray);
            return nameArray;
        } catch (SQLException ex) {
            System.out.println("Enrolment class error: " + ex);
            return null;
        } catch (ServletException ex) {
            System.out.println("Enrolment class error:" + ex);
            return null;
        }
    }
    
     public static ArrayList getAlumni(int schoolID){
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM enrolment \n"
                    +"INNER JOIN users \n"
                    +"ON (enrolment.user_name = users.user_name) \n"
                    +"WHERE enrolment.school_id = '" + schoolID + "'";
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
     
     public static int numberOfSchools() {
        DatabaseAccess database = new DatabaseAccess();
        ResultSet rs;
        try {
            rs = database.runQuery("SELECT COUNT(school_id) AS NumberOfSchools FROM school",database.getConnection());
            if (rs.first()) {
                return rs.getInt("NumberOfSchools");
            } else {
                return -1;
            }
        } catch (SQLException ex) {
        } catch (ServletException ex) {
            Logger.getLogger(Users.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
     
     public static int numberOfAlumni(int schoolID) {
        return getAlumni(schoolID).size();
    }
     
     //persist the school object into the database
    public boolean persist() {
        try {
            String sql;
            DatabaseAccess database;
            database = new DatabaseAccess();
            sql = "INSERT INTO school(name, description, website) "
                    + "VALUES('" + this.name + "', '" + this.description + "', '" + this.website + "');";
            database.runUpdateQuery(sql, database.getConnection());
            return true;
        } catch (ServletException ex) {
            return false;
        //} catch (InsufficientPermissionException ex) {
          //  return false;
        }
    }
}
