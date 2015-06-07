<%-- 
    Document   : editprofile
    Created on : 27-Mar-2014, 14:49:09
    Author     : ypf12pxu
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style2.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="page_container">

            <div id="header">
                <div id="logout"> <p> <a href="Logout.jsp"> Logout</a></p></div>
                 <div id="logout"> <p> <a href="admin.jsp"> Admin</a></p></div>
                <div id="nav">
                    <ul>

                        <a href="profile.jsp"> <li class="active">Home</li></a>
                        <a href="Messages.jsp"><li class ="notactive">Messages</li></a>
                        <a href="ListSchools"><li class="notactive">Schools</li></a>
                    </ul>


                </div>

            </div>


            <div id ="leftsidebar">
                <jsp:useBean id="profilePicUser" type="Beans.Image" scope="session"/>
                <img src="<%=profilePicUser.getPath()%>" alt="Profile Picture" height="280" width="250" border="2"> 
                <div id="buttonb"><a href="">Upload Image</a></div>
                <br/><br/>
                <form action="EditProfile" method="POST">
                    <h3>Name: <input type="text" name="eFirstName" value=${user.firstName}></input> <input type="text" name="eLastName" value=${user.lastName}></input></h3>
                    <br>

                    <td> <div id="buttona"> <a href="editprofile.jsp"> Edit Profile</a></div>

                        <jsp:useBean id="user" type="Beans.Users" scope="session"/>

                        <br>
                        </div>
                        <div id="center">
                            <div id="centerbox">
                            <p><b>Description</b></br><textarea id="textdescription" name="eDescription" cols="40" rows="5"onfocus=";
                                    setbg('#e5fff3');" onblur="setbg('white')">${user.description}</textarea></p>
                            <script>
                                function setbg(color)
                                {
                                    document.getElementById("textdescription").style.background = color
                                }
                            </script>
                            <input type="submit" value="Commit Changes">
                            <a href="profile.jsp">Return to Profile</a>
                            </div>
                        </div>
                        <div id ="rightsidebare">
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
                            <div id="footer"><p>asdsa</p></div>
                        </div>
                        </body>
                        </html>
