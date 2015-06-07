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
                <jsp:useBean id="profilePicUser" type="Beans.Image" scope="session"/>
                <img src="<%=profilePicUser.getPath()%>" alt="Profile Picture" height="280" width="250" border="2"> 
                <div id="buttonb">
                    <form action="UploadProfilePicture" method="POST" enctype="multipart/form-data">
                        <input type="file" name="uploadedPic">
                        <br/>
                        <input type="submit" value="Upload Picture">
                    </form></div>
                <br/><br/>
                <h1>${user.firstName} ${user.lastName}</h1>

                <td> <div id="buttona"> <a href="editprofile.jsp"> Edit Profile</a></div>

                    <jsp:useBean id="user" type="Beans.Users" scope="session"/>

                    <br>
            </div>
            <div id="center">
                <div id="centerbox">
                <p><b>Schools:</b></br></p>
                <table>
                    <th>School</th>
                    <th>Description</th>
                    <th></th>
                        <%
                            List schoolsList = (List) session.getAttribute("schools");
                            Iterator it = schoolsList.iterator();
                            ArrayList<Beans.Enrolment> enrolments = null;
                            if (user != null) {
                                enrolments = Beans.Enrolment.getEnrolments(user.getUsername());
                            }
                            boolean enrolled;
                            while (it.hasNext()) {
                                Beans.School school = (Beans.School) it.next();
                        %>
                    <tr>
                        <td><a href="Profile?username=<%=school.getSchoolID()%>&school=true"><%=school.getName()%></a></td>
                        <td><%=school.getDescription()%></td>
                        <%
                            enrolled = false;
                            for (Beans.Enrolment e : enrolments) {
                                if (e.getSchoolID() == school.getSchoolID()) {
                                    enrolled = true;
                                    break;
                                }
                            }
                            if (!enrolled) {
                        %> <td><a href="manageenrolments.jsp">enrol</a></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
                </div>
            </div>
            <div id ="rightsidebare">
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
                <div id="footer"><p>asdsa</p></div>
        </div>
    </body>
</html>
