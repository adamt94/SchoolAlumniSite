<%-- 
    Document   : Messages
    Created on : Mar 27, 2014, 5:45:39 PM
    Author     : adam
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
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

                        <a href="profile.jsp"><li class="notactive">Home</li></a>
                        <a href="Messages.jsp"><li class ="active">Messages</li></a>
                        <a href="ListSchools"><li class="notactive">Schools</li></a>
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
                <br/>
                <h1>${user.firstName} ${user.lastName}</h1>

                <td> <div id="buttona"> <a href="editprofile.jsp"> Edit Profile</a></div>

                    <jsp:useBean id="user" type="Beans.Users" scope="session"/>

                    <br>
            </div>
            <div id="center">
                <div id="centerbox">
                    <p><b>Messages</b></br></p>
                    <p><b>Received Messages:</b></br></p>




                    <table>
                        <th>Sent by</th>
                        <th>Message</th>

                        <%
                            List messageList = (List) Beans.Message.getReceivedMessages(user);

                            Iterator it = messageList.iterator();
                            while (it.hasNext()) {
                                Beans.Message message = (Beans.Message) it.next();
                        %>
                        <tr>
                            <td><a href="Profile?username=<%=message.getFromUser()%>"><%=message.getFromUser()%></a></td>
                            <td><%=message.getContent()%></td>
                        </tr>

                        <%
                            }
                        %>
                    </table>
                </div>
                    <p></p>
                <div id="centerbox">
                    <div id="messagetable">
                    <p><b>Sent Messages:</b></br></p>
                    <table class="schoolmates">
                        <th>Sent to</th>
                        <th>Message</th>
                            <%
                                messageList = (List)Beans.Message.getSentMessages(user);

                                it = messageList.iterator();
                                while (it.hasNext()) {
                                    Beans.Message message = (Beans.Message) it.next();
                            %>
                        <tr>
                            <td><a href="Profile?username=<%=message.getToUser()%>"><%=message.getToUser()%></a></td>
                            <td><%=message.getContent()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    </div>
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
