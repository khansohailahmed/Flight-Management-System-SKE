package Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/User_Login";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Sohail0622";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            try (Connection con = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                // Prepare SQL query to check if the user exists with the given username and password
                String query = "SELECT * FROM users WHERE username = ? AND password = ?";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, username);
                pst.setString(2, password);

                // Execute the query
                ResultSet rs = pst.executeQuery();

                // Check if user exists
                if (rs.next()) {
                    // Successful login
                    String name = rs.getString("name");

                    // Set the session attribute to indicate the user is logged in
                    HttpSession session = request.getSession(); // Get the current session
                    session.setAttribute("isLoggedIn", true); // Set the login status
                    session.setAttribute("username", username); // Optional: Store username in session

                    out.println("<h3>Login successful! Welcome, " + name + ".</h3>");
                    response.sendRedirect("index.html"); // Redirect to the main page after login
                } else {
                    // Invalid login
                    out.println("<h3 style='color:red;'>Invalid username or password!</h3>");
                }

            } catch (Exception e) {
                out.println("<h3 style='color:red;'>Database connection failed!</h3>");
            }
        } catch (Exception ex) {
            ex.printStackTrace(); // Log the exception for debugging
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Optionally handle GET requests if needed
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet";
    }
}