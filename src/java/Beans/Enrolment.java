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
public class Enrolment {

    private int enrolment_id;
    private int school_id;
    private String user_name;
    private int start_year;
    private int end_year;

    //default constructor
    public Enrolment() {
    }

    public Enrolment(int givenSchoolID, Users givenUser, int givenStart, int givenEnd){
        this.school_id = givenSchoolID;
        this.user_name = givenUser.getUsername();
        this.start_year = givenStart;
        this.end_year = givenEnd;
    }

    public Enrolment(ResultSet rs) throws SQLException {
        this.enrolment_id = rs.getInt("enrolment_id");
        this.school_id = rs.getInt("school_id");
        this.user_name = rs.getString("user_name");
        this.start_year = rs.getInt("start_year");
        this.end_year = rs.getInt("end_year");
    }

    //accessor methods
    public int getEnrolmentID() {
        return this.enrolment_id;
    }

    public int getSchoolID() {
        return this.school_id;
    }

    public String getUserName() {
        return this.user_name;
    }

    public int getStartYear() {
        return this.start_year;
    }

    public int getEndYear() {
        return this.end_year;
    }

    public static ArrayList<Enrolment> getEnrolments(String userName) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM enrolment"
                    + " WHERE user_name = '" + userName + "';";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            ArrayList enrolments = new ArrayList();
            while (rs.next()) {
                enrolments.add(new Enrolment(rs));
            }
            return enrolments;
        } catch (SQLException ex) {
            System.out.println("Enrolment class error: " + ex);
            return null;
        } catch (ServletException ex) {
            System.out.println("Enrolment class error:" + ex);
            return null;
        }
    }

    //create a new enrolment from username and schoolID
    public static void createEnrolments(String userName, String schoolID) {
        //unimplemented
    }

    //other methods
    //persist the enrolment object into the database
    public boolean persist(Users givenUser) {
        try {
            //if (givenUser.isValid()) {
              //  throw new InsufficientPermissionException();
            //}
            String sql;
            DatabaseAccess database;
            database = new DatabaseAccess();
            sql = "INSERT INTO enrolment(school_id, user_name, start_year, end_year) "
                    + "VALUES('" + this.school_id + "', '" + this.user_name + "', '"
                    + this.start_year + "', '" + this.end_year + "');";
            database.runUpdateQuery(sql, database.getConnection());
            return true;
        } catch (ServletException ex) {
            return false;
        //} catch (InsufficientPermissionException ex) {
          //  return false;
        }
    }
    
    public static boolean removeEnrolment(int enrolmentID){
        try {
            String sql;
            DatabaseAccess database;
            database = new DatabaseAccess();
            sql = "DELETE FROM enrolment\n" +
                    "WHERE enrolment_id='" + enrolmentID + "';";
            database.runUpdateQuery(sql, database.getConnection());
            return true;
            
        } catch (ServletException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
            return false;           
        }
    }
}
