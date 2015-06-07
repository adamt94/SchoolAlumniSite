<%-- 
    Document   : admin
    Created on : 29-Mar-2014, 12:08:02
    Author     : Stuart
--%>

<%@page import="java.util.List"%>
<%@page import="Beans.Users"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Package.DatabaseAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>     
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style2.css">
        <title>Admin Page</title>
    </head>
    <body>
        <div id="page_container">
            <%
                Users loggedIn = (Users) session.getAttribute("user");
                if (!loggedIn.isAdmin()) {
                    response.sendError(401, "Not an admin.");
                }
            %>

            <div id="header">
                <div id="logout"> <p> <a href="Logout.jsp"> Logout</a></p></div>
                <div id="logout"> <p> <a href="admin.jsp"> Admin</a></p></div>
                <div id="nav">
                    <ul>

                        <a href="profile.jsp"><li class="active">Home</li></a>
                        <a href="Messages.jsp"><li class ="notactive">Messages</li></a>
                        <a href="ListSchools"><li class="notactive">Schools</li></a>
                    </ul>


                </div>

            </div>
            <div id="leftsidebar">
                <jsp:useBean id="profilePicUser" type="Beans.Image" scope="session"/>
                <img src="<%=profilePicUser.getPath()%>" alt="Profile Picture" height="280" width="250" border="2"> 
                <div id="buttonb">



                    <form action="UploadProfilePicture" method="POST" enctype="multipart/form-data">
                        <input type="file" name="uploadedPic">
                        <br/>
                        <input type="submit" value="Upload Picture">


                    </form>

                </div>
                <br/>
                <h1>${user.firstName} ${user.lastName}</h1>

                <div id="buttona"> <a href="editprofile.jsp"> Edit Profile</a></div>
                <br>
                <div id="buttona"><a href="manageenrolments.jsp">Manage Enrolments</a></div>


                <jsp:useBean id="user" type="Beans.Users" scope="session"/>

                <br>
            </div>
            <div id="center">

                <form action="CreateSchool" method="POST">
                    <h3>School Name: <input type="text" name="eschoolName"></h3>
                    <h3>School Website: <input type="text" name="eschoolURL"></h3>
                    <p><b>Description:</b></br><textarea name="eschoolDescription" cols="40" rows="5"></textarea></p>
                    <input type="submit" value="Create School">
                </form>
                <div id="buttona">
                    <a href="admintables.jsp">View Data</a>
                </div>
            </div>
                <div id="rightsidebare">
                     <form method="post" name="frm" action="SearchUsers">
                    <table border="0" width="300" bgcolor="#CDFFFF">
                        <tr><td colspan=2 style="font-size:12pt;color:#00000;">
                                <h3>Search Item</h3></td></tr>
                        <td><input type="text" name="search">
                        </td></tr>
                        <tr><td colspan=2 align="left">
                                <input type="submit" name="submit" value="Search"></td></tr>
                    </table>
                </form>
                <p><b><h2>Schoolmates</h2></b></p>         
                <table>

                    <%
                        List schoolmatesList = (List) session.getAttribute("schoolmates");
                        Iterator it = schoolmatesList.iterator();
                        while (it.hasNext()) {
                            Beans.Users schoolmate = (Beans.Users) it.next();
                    %>
                    <tr>
                        <td>
                            <a href="Profile?username=<%=schoolmate.getUsername()%>"><%=schoolmate.getFirstName()%>
                                <%=schoolmate.getLastName()%></a></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                </div>

        </div>
    </body>
</html>
