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
            String insertQuery = "INSERT INTO passenger_details2 (name, flight_number, airline, travel_date, from_location, to_location, passenger_count, aadhar, dob, gender, mobile, email, amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);

            // Set parameters from request parameters
            pstmt.setString(1, request.getParameter("name"));
            pstmt.setString(2, request.getParameter("flight_number"));
            pstmt.setString(3, request.getParameter("airline"));
            pstmt.setDate(4, Date.valueOf(request.getParameter("travel_date")));
            pstmt.setString(5, request.getParameter("from_location"));
            pstmt.setString(6, request.getParameter("to_location"));
            pstmt.setInt(7, Integer.parseInt(request.getParameter("passenger_count")));
            pstmt.setString(8, request.getParameter("aadhar"));
            pstmt.setDate(9, Date.valueOf(request.getParameter("dob")));
            pstmt.setString(10, request.getParameter("gender"));
            pstmt.setString(11, request.getParameter("mobile"));
            pstmt.setString(12, request.getParameter("email"));
            pstmt.setDouble(13, Double.parseDouble(request.getParameter("amount")));

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
