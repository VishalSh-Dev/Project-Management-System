/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author admin
 */
@WebServlet(urlPatterns = {"/signup"})
public class signUp extends HttpServlet {

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
            ps=c.prepareStatement("insert into users values (?,?)");
            ps.setString(1, id);
            ps.setString(2, pass);
            rs=ps.executeQuery();
            response.sendRedirect("index.html");
        }catch(Exception e){
            System.out.println(e);
        }
    }

}
