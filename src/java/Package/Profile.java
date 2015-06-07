/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Package;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Stuart
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profile"})
public class Profile extends HttpServlet {

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
            String parameter = request.getParameter("username");
            String parameter2 = request.getParameter("school");
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(60*30);//session will last for 30 minutes of inactivity before timing out
            Beans.Users user = (Beans.Users) session.getAttribute("user");//attempt to get logged in user
            Beans.Image profilePic;
            
            //If somebody is logged in and no username parameter is given
            if (user != null && parameter == null) {
                //get a list of the logged in user's schoolmates
                ArrayList schoolmates = Beans.Users.Schoolmates(user.getUsername());
                //get a list of the user's received messsages
                ArrayList receivedMessages = Beans.Message.getReceivedMessages(user);
                //get a list of the user's sent messsages
                ArrayList sentMessages = Beans.Message.getSentMessages(user);
                profilePic = new Beans.Image(user.getUsername());
                session.setAttribute("schoolmates", schoolmates);
                session.setAttribute("receivedMessages", receivedMessages);
                session.setAttribute("sentMessages", sentMessages);
                session.setAttribute("profilePicUser", profilePic);
                request.getRequestDispatcher("profile.jsp").forward(request, response);

                //else if both parameters are given
            } else if (parameter != null && parameter2!=null) {
                //Set up for a school profile page
                Beans.School school = new Beans.School(Integer.valueOf(parameter));
                ArrayList alumni = Beans.School.getAlumni(Integer.valueOf(parameter));
                session.setAttribute("profile", school);
                session.setAttribute("alumni", alumni);
                request.getRequestDispatcher("viewschool.jsp").forward(request, response);
                
                //else if username parameter is given
            } else if (parameter != null) {
                user = new Beans.Users(parameter);
                profilePic = new Beans.Image(user.getUsername());
                session.setAttribute("profile", user);
                session.setAttribute("profilePic", profilePic);
                request.getRequestDispatcher("viewprofile.jsp").forward(request, response);
                
            } else {
                response.sendRedirect("index.jsp");
            }
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
