/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Package.DatabaseAccess;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;

/**
 *
 * @author ppc12uvu
 */
public class Image {

    private int image_id;
    private String user_name;
    private String img_path;

    //default constructor
    public Image() {
    }

    public Image(String username) {
        populateImage(username);
    }

    //accessor methods
    public int getImageID() {
        return this.image_id;
    }

    public String getUsername() {
        return this.user_name;
    }

    public String getPath() {
        return this.img_path;
    }

    //mutator methods
    public void setImageID(int givenID) {
        this.image_id = givenID;
    }

    public void setUsername(String givenUser) {
        this.user_name = givenUser;
    }

    public void setPath(String givenPath) {
        this.img_path = givenPath;
    }

    private boolean populateImage(String username) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql = "SELECT * FROM image"
                    + " WHERE user_name = '" + username + "';";
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            if (rs.next()) {
                this.image_id = rs.getInt("image_id");
                this.user_name = rs.getString("user_name");
                this.img_path = rs.getString("img_path");
                return true;
            }
        } catch (SQLException ex) {
            System.out.println("Enrolment class error: " + ex);
            return false;
        } catch (ServletException ex) {
            System.out.println("Enrolment class error:" + ex);
            return false;
        }
        return false;//garbage value
    }
    
    public boolean persistImage(){
        try {
            String sql;
            DatabaseAccess database;
            database = new DatabaseAccess();
            sql = "UPDATE Image "
                    + "SET img_path='" + this.img_path + "' "
                    + "WHERE user_name ='" + this.user_name + "';";
            database.runUpdateQuery(sql, database.getConnection());
            return true;
        } catch (ServletException ex) {
            return false;
        //} catch (InsufficientPermissionException ex) {
          //  return false;
        }
    }
    
}
