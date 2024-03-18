<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    
    // Check if the form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        System.out.println("something");
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");

        Connection c = null;
        Statement s = null;
        ResultSet rs = null;
        try{
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/test","root","root");
            System.out.println("Connection established");
            
        }catch(Exception e){
            System.out.println(e);
        }
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Form Validation</title>
    </head>
    <body>

        <form name="myForm" action="" method="post">
            User id: <input type="text" name="id"><br>
            Password: <input type="text" name="pass"><br>
            <!-- Add more form fields as needed -->

            <input type="submit" value="Submit">
        </form>

    </body>
</html>
