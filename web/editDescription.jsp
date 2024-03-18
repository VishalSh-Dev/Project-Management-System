<%@page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% Connection c=null;
    Statement s=null;
    ResultSet rs=null;
    String proj_des="";
    String userID=(String)session.getAttribute("userId");
    String proj_name=(String)session.getAttribute("proj_name");
    String desc = request.getParameter("description");
    try {
        Class.forName("oracle.jdbc.OracleDriver");
        c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
        s = c.createStatement();
        System.out.println("Connected");

        
        rs = s.executeQuery("Select * from Projects where proj_name='"+proj_name+"' and pid = '"+userID+"'");
        rs.next();
        proj_des = rs.getString("description");
    }catch (SQLException | ClassNotFoundException e) {
        System.out.println("Error: " + e.getMessage());
    }
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            assert s != null;
            s.executeUpdate("update Projects set description='"+desc+"' where proj_name='"+proj_name+"' and pid = '"+userID+"'");
            System.out.println("Inserted Successfully");
            response.sendRedirect("ProjectDic.jsp?proj_name="+proj_name);
        }catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Simple Webpage</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }

            #container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333;
            }

            label {
                display: block;
                margin: 10px 0;
                color: #555;
            }

            textarea {
                width: 100%;
                padding: 15px; /* increased padding */
                margin: 5px 0 20px 0; /* increased margin */
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical; /* allows vertical resizing */
            }

            button {
                background-color: #3498db; /* blue color */
                color: #fff;
                padding: 8px 12px; /* reduced padding */
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

            button:hover {
                background-color: #2980b9; /* darker blue on hover */
            }
        </style>
    </head>
    <body>
        <div id="container">
            <h1>Description</h1>
            <form method="post" action="">
                <textarea id="description" name="description" rows="5" cols="30" placeholder="Type your description here..." required><%= proj_des%></textarea>
                <button type="submit">Submit</button>
            </form>
        </div>
    </body>
</html>

