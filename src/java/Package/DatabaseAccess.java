package Package;

import java.sql.*;
import javax.servlet.ServletException;

public class DatabaseAccess {

    //Default constructor
    public DatabaseAccess() {
    }

    //A method for creating database connection
    public Connection getConnection() throws ServletException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            throw new ServletException(String.format("Error: Cannot find JDBC driver..."));
        }
        String username = "postgres"; //Username for database (postgres)
        String password = "adam"; //Password for database (postgres)
        String url = "jdbc:postgresql://localhost/SchoolAlumniSite"; //Url to connect to database
        Connection connection;
        try {
            connection = DriverManager.getConnection(url, username, password);
            return connection;
        } catch (SQLException ex) {
            throw new ServletException(String.format("Error: Connection to database failed..."));
        }
    }

    public boolean runUpdateQuery(String sql, Connection connection) throws ServletException {
        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            statement.executeUpdate(sql);
            connection.close();
            statement.close();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public ResultSet runQuery(String sql, Connection connection) {

        ResultSet rs = null;
        try {
            Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = statement.executeQuery(sql);
            connection.close();//close connection
       } catch (SQLException ex) {
        }
        return rs;
    }
    
    public void executeQuery(String sql, Connection connection) {

        try {
            Connection con = getConnection();
            Statement s = con.createStatement();

            s.execute(sql);
            
            con.close();
            s.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
