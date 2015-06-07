<%-- 
    Document   : index
    Created on : 03-Mar-2014, 23:57:31
    Author     : Stuart
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>School Alumni Site - Login</title>
    </head>
    <body>
     
    	
    	
    
     
        <div id="login">
            <form action="LoginForm" method="POST">
                <div id="nav">
                    <ul>
                        <li class='active'><a href='index.jsp'> Existing User</a><li>
                        <li class="register"><a href='register.jsp'>Register</a></li>
                    </ul>

                </div>

                <p><label>Username</label></p>
                <p><input type="text" name="userName"  placeholder="Username" size="20"></p>
                <p><label>Password</label></p>
                <p><input type="password" name="password" placeholder="Password" size="20"></p>

                <p> <input type="submit" value="Login"></p>
            </form>

        </div>
        <div id="logo">
            
        </div>
        

    </body>
</html>



