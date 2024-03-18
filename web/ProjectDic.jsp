
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>
<%  String currentProj = request.getParameter("proj_name");
    System.out.println(currentProj);
    session.setAttribute("proj_name",currentProj);
    Connection c;
    Statement s;
    ResultSet rs;
    String proj_na="";
    String proj_des="";
    String ui_des="";
    String code_des="";
    String db_des="";
    int ui_per=0;
    int code_per=0;
    int db_per=0;
    try {
            Class.forName("oracle.jdbc.OracleDriver");
            c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
            s = c.createStatement();
            System.out.println("Connected");

            String userID=(String)session.getAttribute("userId");  
            String proj_name=(String)session.getAttribute("proj_name");  
            rs = s.executeQuery("Select * from Projects where proj_name='"+proj_name+"' and pid = '"+userID+"'");
            rs.next();
            proj_na = rs.getString("proj_name");
            proj_des = rs.getString("description");
            ui_des = rs.getString("ui_design");
            code_des = rs.getString("coding_desc");
            db_des = rs.getString("database");
            ui_per = rs.getInt("ui_percentage");
            code_per = rs.getInt("coding_percentage");
            db_per = rs.getInt("database_percentage");
    }catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error: " + e.getMessage());
        }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            display: flex;
            justify-content: center;
            font-family: sans-serif;
        }
        .main{
            display: flex;
            flex-direction: column;
            width: 40%;
            padding: 2%;
            
        }
        .main .box{
            padding-left:5%;
            padding-right:5%;
            padding-bottom: 2%;
            padding-top: 2%;
            margin-bottom: 3%;
            border: solid 1px black;
            border-bottom: solid 1px black;
            box-shadow: 5px 5px 10px 0px rgba(0, 0, 0, 0.5);
            
        }
        .top{
            display: flex;
            justify-content: space-between;
        }
        .bottom textarea{
            width:99%;
            resize: none;
            
            border: none;
        }
        .top label{
            font-weight: bolder;
            color: rgb(32, 142, 252);
            
        }
        .edit-button{
            border: none;
            
        }
        h1{
            text-align: center;
            color: rgb(32, 142, 252);
        }
        
       
    </style>
</head>
<body>
    <div class="main">
        <h1 class="heading"><%= proj_na%></h1>
        
        
        <div class="box">
            <div class="top">
                <label class="label">Description</label>
                <div class="top-right">
                    <a href="editDescription.jsp" style="text-decoration: none;">Edit</a>
                </div>
            </div>
            <div class="bottom">
                <label class="desc"><%=proj_des%></label>
            </div>
        </div>
            
            
        <div class="box">
            <div class="top">
                <label class="label">UI Design</label>
                <div class="top-right">
                    <span><b>Progress: </b></span>
                    <progress id="progress" max="100" value="<%=ui_per%>"></progress>
                    <span><%=ui_per%>%</span>
                    <a href="editUI.jsp" style="text-decoration: none;">Edit</a>
                </div>
            </div>                      
            <div class="bottom">
                <label class="desc"><%=ui_des%></label>
            </div>
        </div>
            
            
        <div class="box">
            <div class="top">
                <label class="label">Coding</label>
                <div class="top-right">
                    <span><b>Progress: </b></span>
                    <progress id="progress" max="100" value="<%=code_per%>"></progress>
                    <span><%=code_per%>%</span>
                    <a href="editCoding.jsp" style="text-decoration: none;">Edit</a>
                </div>
            </div>
            <div class="bottom">
                <label class="desc"><%=code_des%></label>
            </div>
        </div>
            
            
        <div class="box">
            <div class="top">
                <label class="label">Database</label>
                <div class="top-right">
                    <span><b>Progress: </b></span>
                    <progress id="progress" max="100" value="<%=db_per%>"></progress>
                    <span><%=db_per%>%</span>
                    <a href="editDatabase.jsp" style="text-decoration: none;">Edit</a>
                </div>
            </div>
            <div class="bottom">
                <label class="desc"><%=db_des%></label>
            </div>
        </div>
        
    </div>
</body>
</html>
