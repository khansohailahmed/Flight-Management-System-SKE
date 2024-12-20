<%@ page import="java.sql.*" %>
<%
    String pnr = request.getParameter("pnr");
    String seatNumber = request.getParameter("seatNumber");

    if (pnr != null && seatNumber != null) {
        String url = "jdbc:mysql://localhost:3306/User_Login"; // Update with your DB config
        String user = "root"; // Your DB username
        String password = "Sohail0622"; // Your DB password
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String insertQuery = "INSERT INTO boarding_pass (pnr, seat_number) VALUES (?, ?)";
            pst = conn.prepareStatement(insertQuery);
            pst.setString(1, pnr);
            pst.setString(2, seatNumber);
            pst.executeUpdate();

            response.sendRedirect("index.html"); // Redirect to home page
        } catch (Exception e) {
            out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
        } finally {
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("<p style='color: red;'>Invalid data. Please try again.</p>");
    }
%>
