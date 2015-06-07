<%-- 
    Document   : profile
    Created on : 04-Mar-2014, 22:40:49
    Author     : Stuart
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style2.css">
        <title>Profile</title>
    </head>
    <body>
        <div id="page_container">

            <div id="header">
                <div id="logout"> <p> <a href="Logout.jsp"> Logout</a></p></div>
                 <div id="logout"> <p> <a href="admin.jsp"> Admin</a></p></div>
                <div id="nav">
                    <ul>

                        <a href="profile.jsp"><li class="notactive">Home</li></a>
                        <a href="Messages.jsp"><li class ="notactive">Messages</li></a>
                        <a href="ListSchools"><li class="active">Schools</li></a>
                    </ul>


                </div>

            </div>


            <div id ="leftsidebar">
                <jsp:useBean id="profile" type="Beans.School" scope="session"/>
                <h3>Name: ${profile.name}</h3>
                <br>
                <a href="<%=profile.getWebsite()%>">Go to Website</a>
               

            </div>
            <div id="center">
                <p><b>Description:</b></br>${profile.description}</p>
            </div>
            <div id ="rightsidebare">
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
            </div>
                <div id="footer"><p>asdsa</p></div>
        </div>
    </body>
</html>
