import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
@WebServlet(urlPatterns={"/ProjectList"})
public class ProjectList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    static Connection c;
    static Statement s;
    static ResultSet rs;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","nitin","1234");
            s = c.createStatement();
            System.out.println("Connected");

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error: " + e.getMessage());
        }
        PrintWriter out = response.getWriter();
        HttpSession session=request.getSession(false);  
        String userID=(String)session.getAttribute("userId");  
        
        try {
            rs = s.executeQuery("Select * from Projects where p=="+userID);
            System.out.println("Fetched");
            out.println( "<!DOCTYPE html>"
                    +"<html >"
                    +"<head>"
                    +"<title>Project Management System</title>"
                    +"<style>"
                            +"body {"
                                    +"font-family: Arial, sans-serif;"
                                    +"background-color: #f4f4f4;"
                                    +"color: #333;"
                                    +"margin: 0;"
                                    +"padding: 0;"
                                    +"display: flex;"
                                    +"flex-direction: column;"
                                    +"align-items: center;"
                                +"}"

                        +"h1 {"
                            +"text-align: center;"
                            +"color: #007BFF;"
                        +"}"

                        +".box {"
                            +"display: flex;"
                            +"flex-direction: column;"
                            +"padding: 15px;"
                            +"border: 2px solid #333;"
                            +"border-radius: 8px;"
                            +"margin-bottom: 20px;"
                            +"width: 300px;"
                            +"background-color: #fff;"
                            +"box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);"
                        +"}"

                        +".box a {"
                            +"text-decoration: none;"
                            +"color: #007BFF;"
                            +"font-weight: bold;"
                            +"font-size: 18px;"
                            +"margin-bottom: 5px;"
                        +"}"

                        +".box p {"
                            +"margin: 0;"
                            +"font-size: 14px;"
                            +"color: grey;"
                        +"}"

                        +"button {"
                            +"padding: 10px;"
                            +"background-color: #007BFF;"
                            +"color: #fff;"
                            +"border: none;"
                            +"border-radius: 4px;"
                            +"cursor: pointer;"
                            +"font-size: 16px;"
                            +"margin-top: 20px;"
                        +"}"

                        +"button:hover {"
                            +"background-color: #0056b3;"
                        +"}"
                    +"</style>"

          +"</head>"
          +"<body>"
                    +"<h1>Project Management System</h1>"

            );
            while(rs.next()){
                out.println("<div class=\"box\">"
                        +"<a href=\"ProjectDic.jsp\">"+rs.getString("proj_name")+"</a>"
                        +"<p>"+rs.getString("description")+"</p>"
                    +"</div>");
                }
            }
          catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        
        session.setAttribute("proj_name","pn");
        out.println("<button onclick=\"href='ProjectDic.jsp'\">Add a New Project</button>"
            +"</body>"
            +"</html>");
        
    }
        
}
