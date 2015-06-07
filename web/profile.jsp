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
                <p class="logout"> <a href="Logout.jsp"> Logout</a></p>
                 <p class="logout"> <a href="admin.jsp"> Admin</a></p>
                <div id="nav">
                    <ul>
                        <a href="profile.jsp"><li class="active">Home</li></a>
                        <a href="Messages.jsp"><li class ="notactive">Messages</li></a>
                        <a href="ListSchools"><li class="notactive">Schools</li></a>
                    </ul>

                </div>

            </div>


            <div id ="leftsidebar">
                <jsp:useBean id="profilePicUser" type="Beans.Image" scope="session"/>
                <img src="<%=profilePicUser.getPath()%>" alt="Profile Picture" height="280" width="250"> 
                <div id="buttonb">



                    <form action="UploadProfilePicture" method="POST" enctype="multipart/form-data">
                        <input type="file" name="uploadedPic">
                        <br/>
                        <input type="submit" value="Upload Picture">


                    </form>

                </div>
                <br/>
                <h1>${user.firstName} ${user.lastName}</h1>

                 <a class="buttona" href="editprofile.jsp"> Edit Profile</a>
                <br>
                <a class="buttona" href="manageenrolments.jsp">Manage Enrolments</a>


                <jsp:useBean id="user" type="Beans.Users" scope="session"/>

                <br>
            </div>
            <div id="center">
                <div id="centerbox">

                    <p><b>Description:</b> ${user.description}</p>
                </div>

            </div>
            <div id ="rightsidebare">
                <form method="post" name="frm" action="SearchUsers">
                    <table>
                        <tr><td>
                                <h3>Search Item</h3></td></tr>
                        <tr> <td><input type="text" name="search"></td></tr>

                        <tr><td>
                                <input type="submit" name="submit" value="Search"></td></tr>
                    </table>
                </form>
                <h2>Schoolmates</h2>       
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
            <div id="footer"><p>asdsa</p></div>
        </div>
    </body>
</html>
