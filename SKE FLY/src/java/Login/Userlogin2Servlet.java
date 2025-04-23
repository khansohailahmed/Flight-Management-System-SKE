package Login;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/Userlogin2Servlet")
public class Userlogin2Servlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String jdbcURL = "jdbc:mysql://localhost:3306/User_Login"; // Change DB name
        String dbUser   = "root"; // Change user
        String dbPass = "Sohail0622"; // Change password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser , dbPass);

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("isLoggedIn", true); // backend session check

                // Redirect to index.html and set localStorage values
                response.setContentType("text/html");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("localStorage.setItem('isLoggedIn', 'true');");
                response.getWriter().println("localStorage.setItem('username', '" + username + "');");
                response.getWriter().println("window.location.href='index.html';");
                response.getWriter().println("</script>");
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Invalid username or password');");
                response.getWriter().println("location='userlogin2.jsp';");
                response.getWriter().println("</script>");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}