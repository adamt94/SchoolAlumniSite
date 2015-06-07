<%-- 
    Document   : viewschool
    Created on : 06-Mar-2014, 12:24:52
    Author     : ppc12uvu
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>School Profile</title>
    </head>
    <body>
        <jsp:useBean id="profile" type="Beans.School" scope="session"/>
        <h3>Name: ${profile.name}</h3>
        <br>
        <p><b>Description:</b></br>${profile.description}</p>
        <p><b>Alumni:</b></br></p>
        <table>
            <%
                List alumniList = (List) session.getAttribute("alumni");
                Iterator it = alumniList.iterator();
                while (it.hasNext()) {
                    Beans.Users alumni = (Beans.Users) it.next();
            %>
            <tr>
                <td><%=alumni.getFirstName()%></td>
                <td><%=alumni.getLastName()%></td>
                <td><a href="Profile?username=<%=alumni.getUsername()%>">Profile</a></td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
