<%-- 
    Document   : register
    Created on : Mar 6, 2014, 8:24:35 PM
    Author     : adam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="login">
            <form action="NewUserForm" method="POST">
                <div id="nav">
                    <ul>
                        <li><a href='index.jsp'> Existing User</a><li>
                        <li class='active2'><a href='register.jsp'>Register</a></li>
                    </ul>

                </div>

                <p><label >Username</label></p>
                <p><input type="text" name="userName"  placeholder="Username" size="20"></p>
                
                <p><label>Password</label></p>
                <p><input type="password" name="password" placeholder="Password" size="20"></p>
                
                <p><label>First Name</label></p>
                <p> <input type="text" name="firstName" placeholder ="First name" size="20" required></p>
                
                <p><label>Second Name</label></p>
                <p><input type="text" name="lastName" placeholder ="Last name" size="20" required></p>
                    
                
              





                <p> <input type="submit" value="Login" name="commit"></p>
               
            </form>
            
        </div>
        <div id="logo"></div>
    </body>
</html>
