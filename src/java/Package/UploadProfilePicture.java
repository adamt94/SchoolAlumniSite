/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Package;

import Beans.Image;
import Beans.Users;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Stuart
 */
@WebServlet(name = "UploadProfilePicture", urlPatterns = {"/UploadProfilePicture"})
@MultipartConfig
public class UploadProfilePicture extends HttpServlet {

    private File uploadFolder;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
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
            Users user = (Users) session.getAttribute("user");
            if (user == null) {
                throw new UserDetailsExpiredException("User details have expired.");
            }
            final String path = getServletContext().getRealPath("")
                    + File.separator + "img\\Profile\\" + user.getUsername();

            Part filePart = request.getPart("uploadedPic");
            String fileExtension = getFileName(filePart).replaceAll("^.*\\.([^.]+)$", "$1");
            if (!fileExtension.equals("jpg")) {
                throw new InvalidFileException("File extension must be jpg.");
            }
            final String fileName = "Profile.jpg";

            OutputStream out1 = null;
            InputStream filecontent = null;
            final PrintWriter writer = response.getWriter();
            File theDir = new File(path);
            theDir.mkdirs();
            theDir = new File(path + File.separator + fileName + "\\");
            out1 = new FileOutputStream(theDir);
            filecontent = filePart.getInputStream();
            int read = 0;
            final byte[] bytes = new byte[1024];

            while ((read = filecontent.read(bytes)) != -1) {
                out1.write(bytes, 0, read);
            }
            writer.println(fileName + " created at " + path);
            Image image = new Image(user.getUsername());
            image.setPath("img/Profile/" + user.getUsername() + "/" + fileName);
            image.persistImage();
            response.sendRedirect("Profile");
        } catch (UserDetailsExpiredException e) {
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            out.println(e);
        } catch (IllegalStateException e) {
            out.println(e);
        } catch (ServletException e) {
            out.println(e);
        } catch (InvalidFileException ex) {
            response.sendError(400,ex.toString());
        } finally {
            out.close();
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("content-disposition header= " + contentDisp);
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
