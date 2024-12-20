<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store Passenger Data</title>
</head>
<body>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User_Login", "root", "Sohail0622");

            // Prepare SQL statement to insert passenger details
            String insertQuery = "INSERT INTO passenger_details2 (name, flight_number, airline, travel_date, from_location, to_location, passenger_count, aadhar, dob, gender, mobile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);

            // Set parameters from session attributes
            pstmt.setString(1, (String) session.getAttribute("name"));
            pstmt.setString(2, (String) session.getAttribute("flight_number"));
            pstmt.setString(3, (String) session.getAttribute("airline"));
            pstmt.setDate(4, (Date) session.getAttribute("travel_date"));
            pstmt.setString(5, (String) session.getAttribute("from_location"));
            pstmt.setString(6, (String) session.getAttribute("to_location"));
            pstmt.setInt(7, (Integer) session.getAttribute("passenger_count"));
            pstmt.setString(8, (String) session.getAttribute("aadhar"));
            pstmt.setDate(9, (Date) session.getAttribute("dob"));
            pstmt.setString(10, (String) session.getAttribute("gender"));
            pstmt.setString(11, (String) session.getAttribute("mobile"));

            // Execute the insert
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<h3>Passenger details stored successfully!</h3>");
            } else {
                out.println("<h3>Error storing passenger details.</h3>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            // Close resources
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</body>
</html>