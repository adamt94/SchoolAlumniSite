
<%-- 
    Document   : editprofile
    Created on : 08-Mar-2014, 18:35:28
    Author     : Stuart
--%>

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
                <div id="nav">
                    <ul>

                        <li class="active">Home</li>
                        <li>My Profile</li>
                    </ul>


                </div>

            </div>
            <div id ="leftsidebar">
            <jsp:useBean id="user" type="Beans.Users" scope="session"/>
            <form action="EditProfile" method="POST">
                <h3>Name: <input type="text" name="eFirstName" value=${user.firstName}></input> <input type="text" name="eLastName" value=${user.lastName}></input></h3>
                <br>
                </div>
                 <div id="center">
                <p><b>Description:</b></br><textarea name="eDescription" cols="40" rows="5">${user.description}</textarea></p>
                <input type="submit" value="Commit Changes">
                <a href="profile.jsp">Return to Profile</a>
                 </div>
                <div id ="rightsidebare"></div>
                
        </div>
    </form>
</body>
</html>
