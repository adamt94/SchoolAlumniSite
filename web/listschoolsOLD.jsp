<%-- 
    Document   : listschools
    Created on : 06-Mar-2014, 10:12:13
    Author     : ppc12uvu
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <p><b>Schools:</b></br></p>
        <table>
            <%
                List schoolsList = (List) session.getAttribute("schools");
                Iterator it = schoolsList.iterator();
                while (it.hasNext()) {
                    Beans.School school = (Beans.School) it.next();
            %>
            <tr>
                <td><a href="Profile?username=<%=school.getSchoolID()%>&school=true"><%=school.getName()%></a></td>
                <td><%=school.getDescription()%></td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
