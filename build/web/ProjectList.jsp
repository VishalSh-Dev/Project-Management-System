<%-- 
    Document   : ProjectList
    Created on : 25-Nov-2023, 12:31:14 am
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Project Management System</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            h1 {
                text-align: center;
                color: #007BFF;
            }

            .box {
                display: flex;
                flex-direction: column;
                padding: 15px;
                border: 2px solid #333;
                border-radius: 8px;
                margin-bottom: 20px;
                width: 300px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .box a {
                text-decoration: none;
                color: #007BFF;
                font-weight: bold;
                font-size: 18px;
                margin-bottom: 5px;
            }

            .box p {
                margin: 0;
                font-size: 14px;
                color: grey;
            }

            button {
                padding: 10px;
                background-color: #007BFF;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 20px;
            }

            button:hover {
                background-color: #0056b3;
            }
        </style>

    </head>
    <body>
        <h1>Project Management System</h1>
        <%
            try {
            Connection c = null;
            Statement s = null;
            ResultSet rs = null;
            Class.forName("oracle.jdbc.OracleDriver");
            c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
            s = c.createStatement();
            System.out.println("Connected");
            String userID=(String)session.getAttribute("userId"); 
            System.out.println("Session variable: "+userID);
            rs = s.executeQuery("Select * from Projects where pid='"+userID+"'");
            System.out.println("Fetched");
            session.setAttribute("proj_name","pn");
                while(rs.next()){
                out.println("<div class=\"box\">"
                        +"<a href=\"ProjectDic.jsp?proj_name="+rs.getString("proj_name")+"\">"+rs.getString("proj_name")+"</a>"
                        +"<p>"+rs.getString("description")+"</p>"
                    +"</div>");
                }
            }
            
          catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }%>
         

        <button onclick="window.location.href = 'AddProject.jsp'">Add a New Project</button>
    </body>
</html>
