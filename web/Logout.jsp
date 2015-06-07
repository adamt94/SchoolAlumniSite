<%-- 
    Document   : Logout
    Created on : 05-Mar-2014, 00:26:37
    Author     : Stuart
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Logout</title>
    </head>
    <body>
        <jsp:useBean id="user" type="Beans.Users" scope="session"/>
        <h1>Confirm Logout Page</h1>
        <h2>${user.username} are you sure you wish to log out?</h2>
        <p><a href="Logout">Confirm Logout</a></p>
    </body>
</html>
