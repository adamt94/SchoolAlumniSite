<%-- 
    Document   : admintables
    Created on : Mar 30, 2014, 4:29:52 PM
    Author     : adam
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Package.DatabaseAccess"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="Beans.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
           <link rel="stylesheet" type="text/css" href="style2.css">
        <title>JSP Page</title>
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

                <table>
            <th>Number of Users</th>
            <th>Number of Schools</th>
            <tr>
                <td><%=Beans.Users.numberOfUsers()%></td>
                <td><%=Beans.School.numberOfSchools()%></td>
            </tr>
        </table>

        <table>
            <th>User</th>
            <th>Schools</th>
            <th>Messages Sent</th>
            <th>Messages Received</th>
                <%
                    DatabaseAccess database = new DatabaseAccess();
                    ResultSet rs;
                    int messagesSent = -1, messagesReceived = -1;

                    ArrayList<Beans.Users> users = Beans.Users.getAllUsers();
                    ArrayList<Beans.School> usersSchools = new ArrayList();
                    Iterator it = users.iterator();
                    Beans.Users user;
                    while (it.hasNext()) {
                        user = (Beans.Users) it.next();

                        try {
                            rs = database.runQuery("SELECT COUNT(message_id) AS NumberOfSent FROM message "
                                    + "WHERE from_user = '" + user.getUsername() + "'", database.getConnection());
                            if (rs.first()) {
                                messagesSent = rs.getInt("NumberOfSent");
                            }
                            rs = database.runQuery("SELECT COUNT(message_id) AS NumberOfReceived FROM message "
                                    + "WHERE to_user = '" + user.getUsername() + "'", database.getConnection());
                            if (rs.first()) {
                                messagesReceived = rs.getInt("NumberOfReceived");
                            }
                            rs = database.runQuery("SELECT DISTINCT school.name, school.school_id FROM enrolment INNER JOIN school "
                                    + "ON (enrolment.school_id = school.school_id) "
                                    + "WHERE user_name = '" + user.getUsername() + "'", database.getConnection());
                            while (rs.next()) {
                                usersSchools.add(new Beans.School(rs.getInt("school_id")));
                            }
                        } catch (SQLException ex) {
                        }
                %>
            <tr>
                <td><%=user.getUsername()%></td>
                <td>
                    <table>
                        <%
                            for (Beans.School s : usersSchools) {

                        %>

                        <tr><td><%=s.getName()%></td></tr>
                        <%
                            }
                        %>
                    </table>
                </td>
                <td><%=messagesSent%></td>
                <td><%=messagesReceived%></td>
            </tr>
            <%
                }
            %>
        </table>

        <table>
            <th>School</th>
            <th>Number of Alumni</th>
                <%
                    ArrayList<Beans.School> schools = Beans.School.getAllSchools();
                    it = schools.iterator();
                    Beans.School school;
                    while (it.hasNext()) {
                        school = (Beans.School) it.next();
                %>
            <tr>
                <td><%=school.getName()%></td>
                <td><%=Beans.School.numberOfAlumni(school.getSchoolID())%></td>
            </tr>
            <%
                }
            %>
        </table>
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
                         it = schoolmatesList.iterator();
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
