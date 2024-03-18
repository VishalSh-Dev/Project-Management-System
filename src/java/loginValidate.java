/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet(urlPatterns = {"/loginValidate"})
public class loginValidate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("username");
        String pass = request.getParameter("password");


        Connection c=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        try{
            
            Class.forName("oracle.jdbc.OracleDriver");
            c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
            System.out.println("Connection established");
            ps=c.prepareStatement("select * from users where id=? and pass=?");
            ps.setString(1, id);
            ps.setString(2, pass);
            rs=ps.executeQuery();
            PrintWriter out=response.getWriter();
                if(rs.next()){
                    System.out.println("matched found");
                    HttpSession session=request.getSession();
                    session.setAttribute("userId",id);
                    response.sendRedirect("ProjectList.jsp");
                }
                else{
                 out.println("<h1>Invalid login detail<h1>");
                 out.println("<a href=\"index.html\">Login Page</a>");
                }

            
          
            
        }catch(Exception e){
            System.out.println(e);
        }
    }


}
