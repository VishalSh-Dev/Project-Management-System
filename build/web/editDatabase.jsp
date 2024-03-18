<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>

<%    
    Connection c=null;
    Statement s=null;
    ResultSet rs=null;
    String userID=(String)session.getAttribute("userId");
    String proj_name=(String)session.getAttribute("proj_name");

    String db_des= "";
    int db_per = 0;
    try {
        Class.forName("oracle.jdbc.OracleDriver");
        c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
        s = c.createStatement();
        System.out.println("Connected");

        
        rs = s.executeQuery("Select * from Projects where proj_name='"+proj_name+"' and pid = '"+userID+"'");
        rs.next();
        db_des = rs.getString("database");
        db_per = rs.getInt("database_percentage");
    }catch (SQLException | ClassNotFoundException e) {
        System.out.println("Error: " + e.getMessage());
    }
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            assert s != null;
            String dbDesc = request.getParameter("dbDesc");
            int dbPer = Integer.parseInt(request.getParameter("dbPer"));
            s.executeUpdate("update Projects set database='"+dbDesc+"', database_percentage='"+dbPer+"' where proj_name='"+proj_name+"' and pid = '"+userID+"'");
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
    <title>Database Form</title>
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

        textarea, input[type="number"] {
            width: 100%;
            padding: 15px;
            margin: 5px 0 20px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div id="container">
        <h1><%= proj_name%> Database</h1>
        <form action="" method="post">
            <textarea id="databaseDesc" name="dbDesc" rows="5" cols="30" placeholder="Type your Database here..." required><%= db_des%></textarea>

            <label for="dbPercentage">Database Percentage:</label>
            <input type="number" id="dbPercentage" name="dbPer" placeholder="Enter Database percentage..." value=<%= db_per %> required></input>

            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
