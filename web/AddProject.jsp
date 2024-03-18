
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>

<%
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        System.out.println("something");
        String id = request.getParameter("id");
        String pass = request.getParameter("pass");
   
        Connection c;
        Statement s;
        ResultSet rs;
        String proj_na=request.getParameter("proj_name");
        String proj_des=request.getParameter("proj_des");
        String ui_des=request.getParameter("ui_des");
        String code_des=request.getParameter("code_des");
        String db_des=request.getParameter("db_des");
        int ui_per=Integer.parseInt(request.getParameter("ui_per"));
        int code_per=Integer.parseInt(request.getParameter("code_per"));
        int db_per=Integer.parseInt(request.getParameter("db_per"));
        try {
                Class.forName("oracle.jdbc.OracleDriver");
                c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
                s = c.createStatement();
                System.out.println("Connected add project");

                String PID=(String)session.getAttribute("userId");  

                s.executeUpdate("Insert into Projects values('"+PID+"','"+proj_na+"','"+proj_des+"','"+ui_des+"',"+ui_per +", '"+code_des+"', "+code_per+", '"+db_des+"', "+db_per+")");
                System.out.println("Inserted Successfully");
//                s.executeUpdate("commit");
                session.setAttribute("proj_name",proj_na);
                response.sendRedirect("ProjectDic.jsp?proj_name="+proj_na);    

        }catch (SQLException | ClassNotFoundException e) {
                System.out.println("Error: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            
        }
        h1{
            text-align: center;
            margin-top: -1%;
        }
        .main{
            display: flex;
            flex-direction: column;
            width: 100%;
            padding: 1%;

            box-shadow: 5px 5px 10px 0px rgba(0, 0, 0, 0.5);
            
        }
        label,input{
            font-size: medium;
        }
        .main div{
            padding-bottom: 4%;
        }
        .one{
            display: grid;
            grid-template-columns: 1fr 1fr;
        }
        .two{
            margin-top: 2%;
            display: flex;
            justify-content: space-evenly;
        }
        textarea{
            resize: none;
        }
        label{
            font-weight: 600;
        }
        label, h1{
            color: rgb(32, 142, 252);
        }
        input,textarea{
            
        }
        .btn{
            background-color: rgb(32, 142, 252);
            color: white;
            border: 1px solid white;
            padding: 5px;
        }
        form{
            display: flex;
            justify-content: space-around;
        }
        
    </style>
</head>
<body>
        <form action="" method="post" name = "New Project">
    <div class="main">
        <h1>New Project</h1>
        <div class="one">
            <label>Name</label>
            <input type="text" name="proj_name" required>
        </div>
        <div class="one">
            <label>Description</label>
            <textarea cols="25" rows="3" name="proj_des" required></textarea>
        </div>
        <div class="one">
            <label>UI Design</label>
            <textarea cols="25" rows="3" name="ui_des" required></textarea>
        </div>
        <div class="one">
            <label>UI Percentage</label>
            <input type="number" min="0" max="100" class="num" name="ui_per" required>
        </div>
            <div class="one">
            <label>Coding</label>
            <textarea cols="25" rows="3" name="code_des" required></textarea>
        </div>
        <div class="one">
            <label>Coding Percentage</label>
            <input type="number" min="0" max="100" class="num" id="input" name="code_per">
        </div>
        <div class="one">
            <label>Database</label>
            <textarea cols="25" rows="3" name="db_des" required></textarea>
        </div>
        <div class="one">
            <label>Database Percentage</label>
            <input type="number" min="0" max="100" class="num" name="db_per" required>
        </div>
        <div class="two">
            <input type="submit" class="btn">
            <input type="reset" class="btn">
        </div>
    </div>
        </form>
</body>
</html>