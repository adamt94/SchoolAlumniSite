<%-- 
    Document   : manageenrolments
    Created on : 28-Mar-2014, 02:26:05
    Author     : Stuart
--%>

<%@page import="Beans.School"%>
<%@page import="Beans.Enrolment"%>
<%@page import="java.util.ArrayList"%>
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

                        <a href="profile.jsp"><li class="active">Home</li></a>
                        <a href="Messages.jsp"><li class ="notactive">Messages</li></a>
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
                <br/><br/>
                <jsp:useBean id="user" type="Beans.Users" scope="session"/>
                <h1>${user.firstName} ${user.lastName}</h1>

                 <div id="buttona"> <a href="editprofile.jsp"> Edit Profile</a></div>
                 <br>
                 <div id="buttona"><a href="manageenrolments.jsp">Manage Enrolments</a></div>
                    

                    

                    <br>
            </div>
            <div id="center">
                <div id="centerbox">
         
                <form action="CreateEnrolment" method="POST">
            <h3>Name: <input type="text" name="eFirstName" disabled="true" value=${user.firstName}></input> <input type="text" name="eLastName" disabled="true" value=${user.lastName}></input></h3>
            <br>
            <%
                ArrayList<Beans.School> schoolsList = Beans.School.getAllSchools();

            %>
            School: 
            <select name="schoolID">
                <%for (Beans.School s : schoolsList) {%>
                <option value="<%=s.getSchoolID()%>"><%=s.getName()%></option>
                <% }%>
            </select>
            <br></br>
            Start Year: 
            <select name="startYear">
                <%for (int i = 1900; i < 2015; i++) {%>
                <option value="<%=i%>"><%=i%></option>
                <% }%>
            </select>
            End Year: 
            <select name="endYear">
                <%for (int i = 1900; i < 2015; i++) {%>
                <option value="<%=i%>"><%=i%></option>
                <% }%>
            </select>
            <br></br>
            <input type="submit" value="Create Enrolment">
            <a href="profile.jsp">Return to Profile</a>
        </form>
        <table>
            <tr>
                <th>School</th>
                <th>Start Year</th>
                <th>End Year</th>
                <th></th>
            </tr>
            <%
                Beans.Users user2 = (Beans.Users) session.getAttribute("user");
                if (user2 == null) {
                    response.sendRedirect("index.jsp");
                }
                ArrayList<Beans.Enrolment> enrolments = Beans.Enrolment.getEnrolments(user.getUsername());
                Iterator it = enrolments.iterator();
                School school;

                while (it.hasNext()) {
                    Enrolment enrolment = (Enrolment) it.next();
                    school = new School(enrolment.getSchoolID());
            %>

            <tr>
                <td><%=school.getName()%></td>
                <td><%=enrolment.getStartYear()%></td>
                <td><%=enrolment.getEndYear()%></td>
            <form action="ManageEnrolments" method="POST">
                <input type ="hidden" value="<%=enrolment.getEnrolmentID()%>" name="enrolmentID">
                <td><input type="submit" value="Remove"></td>     
            </form>
        </tr>

        <%
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
