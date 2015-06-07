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
                <div id="nav">
                    <ul>

                        <a href="profile.jsp"><li class="notactive">Home</li></a>
                        <a href="Messages.jsp"><li class ="active">Messages</li></a>
                    </ul>


                </div>

            </div>

            <div id ="leftsidebar">
                <jsp:useBean id="profilePic" type="Beans.Image" scope="session"/>
                <img src="<%=profilePic.getPath()%>" alt="Profile Picture" height="280" width="250" border="2"> 
                <br/><br/>
                <jsp:useBean id="profile" type="Beans.Users" scope="session"/>
                <h1>${profile.firstName} ${profile.lastName}</h1>

                <br>
            </div>
            <div id="center">
                <p><b>Description:</b></br>${profile.description}</p>
                <%
                    try {
                        Beans.Users user = (Beans.Users) session.getAttribute("user");
                        if (user != null) {
                %> 
                <form action="NewMessage" method="POST">
                    <h3>Message: <br><textarea name="message" cols="40" rows="5" length="300"></textarea></p>
                        <input type="submit" value="Send Message">
                        </form>
                        <%                                }
                            } catch (Exception e) {
                            }
                        %>
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
                        </div>
                        </body>
                        </html>
