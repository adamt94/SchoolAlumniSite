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
public class Message {

    private int message_id;
    private String to_user;
    private String from_user;
    private String content;
    
    //default constructor
    public Message(){}
    
    public Message(String toUser, String fromUser, String message){
        this.to_user = toUser;
        this.from_user = fromUser;
        this.content = message;
    }
    
    public Message(ResultSet rs) throws SQLException{
        this.message_id = rs.getInt("message_id");
        this.to_user = rs.getString("to_user");
        this.from_user = rs.getString("from_user");
        this.content = rs.getString("content");
    }

    //accessor methods
    public int getMessageID() {
        return this.message_id;
    }

    public String getToUser() {
        return this.to_user;
    }

    public String getFromUser() {
        return this.from_user;
    }

    public String getContent() {
        return this.content;
    }

    //mutator methods
    public void setToUser(String givenUser) {
        this.to_user = givenUser;
    }

    public void setFromUser(String givenUser) {
        this.from_user = givenUser;
    }

    public void setContent(String givenMessage) {
        this.content = givenMessage;
    }
    
    //add the user object to the database
    public boolean persistMessage() {
        try {
            String sql;
            DatabaseAccess database;
            database = new DatabaseAccess();
            sql = "INSERT INTO message(to_user, from_user, content) "
                    + "VALUES('" + this.to_user + "', '" + this.from_user + "', '"
                    + this.content + "');";
            database.runUpdateQuery(sql, database.getConnection());
            return true;
        } catch (ServletException ex) {
            return false;
        }
    }

    public static ArrayList<Message> getReceivedMessages(Users user) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql;
            ResultSet rs;
            ArrayList<Message> messages = new ArrayList();
            sql = "SELECT * FROM message\n"
                    + " WHERE to_user = '" + user.getUsername() + "'";
            rs = database.runQuery(sql, database.getConnection());
            while (rs.next()) {
                messages.add(new Message(rs));
            }
            return messages;
        } catch (ServletException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NullPointerException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;//garbage value
    }
    
    public static ArrayList<Message> getSentMessages(Users user) {
        try {
            DatabaseAccess database;
            database = new DatabaseAccess();
            String sql;
            ResultSet rs;
            ArrayList<Message> messages = new ArrayList();
            sql = "SELECT * FROM message\n"
                    + " WHERE from_user = '" + user.getUsername() + "'";
            rs = database.runQuery(sql, database.getConnection());
            while (rs.next()) {
                messages.add(new Message(rs));
            }
            return messages;
        } catch (ServletException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NullPointerException ex) {
            Logger.getLogger(Enrolment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;//garbage value
    }
    
}
