/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Package;

import Beans.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ppc12uvu
 */
@WebServlet(name = "SearchUsers", urlPatterns = {"/SearchUsers"})
public class SearchUsers extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            String search = request.getParameter("search");
            String[] searchTerms = search.split(" ");
            String sql = null;
            if(searchTerms.length == 1){
                sql = "SELECT * FROM users"
                    + " WHERE UPPER(user_name) LIKE UPPER('%" + search + "%') "
                    + "OR UPPER(first_name) LIKE UPPER('%" + search + "%') "
                    + "OR UPPER(last_name) LIKE UPPER('%" + search+ "%')";
            }
            if(searchTerms.length == 2){
                sql = "SELECT * FROM users"
                    + " WHERE UPPER(user_name) LIKE UPPER('%" + search + "%') "
                    + "OR UPPER(first_name) LIKE UPPER('%" + searchTerms[0] + "%') "
                    + "OR UPPER(last_name) LIKE UPPER('%" + searchTerms[1]+ "%')";
            }
            DatabaseAccess database;
            database = new DatabaseAccess();
            ResultSet rs;
            rs = database.runQuery(sql, database.getConnection());
            ArrayList<Users> user = new ArrayList();
            while (rs.next()) {
                user.add(new Users(rs));
            }
            session.setAttribute("searchResults", user);
            response.sendRedirect("searchresults.jsp");
        } catch (SQLException ex) {
            System.out.println("User class error: " + ex);
        } catch (ServletException ex) {
            System.out.println("User class error:" + ex);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
