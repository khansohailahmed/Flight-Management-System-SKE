<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Payment Success</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                position: relative;
            }
            .home-button {
                position: absolute;
                top: 20px;
                left: 20px;
                text-align: center;
            }
            .home-button button {
                padding: 10px 20px;
                font-size: 16px;
                color: white;
                background-color: #4CAF50;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .home-button button:hover {
                background-color: #45a049;
            }
            .success-container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            h1 {
                color: #4CAF50;
            }
            p {
                font-size: 18px;
                margin: 10px 0;
            }
            .fetch-container {
                margin-top: 20px;
            }
            .fetch-container input {
                padding: 10px;
                font-size: 16px;
                width: 200px;
                margin-right: 10px;
            }
            .fetch-container button {
                padding: 10px 20px;
                font-size: 16px;
                color: white;
                background-color: #007BFF;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .fetch-container button:hover {
                background-color: #0056b3;
            }
            .ok-button {
                margin-top: 15px;
                text-align: center;
            }
            .ok-button button {
                padding: 12px 24px;
                font-size: 18px;
                color: white;
                background-color: #4CAF50;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .ok-button button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <!-- Home Page Button -->
        <div class="home-button">
            <button onclick="window.location.href = 'index.html'">Go to Home Page</button>
        </div>

        <!-- Success Message -->
        <div class="success-container">
            <h1>Payment Successful!</h1>
            <p>Your PNR is:</p>
            <h2>
                <%
                    Integer pnr = (Integer) session.getAttribute("pnr");
                    String pnrStr = (pnr != null) ? pnr.toString() : "N/A";
                    out.print(pnrStr);
                %>
            </h2>
        </div>

        <!-- Fetch Passenger Details -->
        <div class="fetch-container">
            <h3>Fetch Passenger Details</h3>
            <form method="post">
                <input type="text" name="mobile" placeholder="Enter Mobile Number" required>
                <button type="submit" name="fetchButton">Fetch</button>
            </form>

            <%
                if (request.getParameter("fetchButton") != null) {
                    String mobile = request.getParameter("mobile");
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User_Login", "root", "Sohail0622");

                        // Query to fetch passenger details based on mobile number
                        String query = "SELECT * FROM passenger_details WHERE mobile = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, mobile);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            // Store fetched details into session attributes
                            session.setAttribute("name", rs.getString("name"));
                            session.setAttribute("flight_number", rs.getString("flight_number"));
                            session.setAttribute("airline", rs.getString("airline"));
                            
                            
                            session.setAttribute("travel_date", rs.getDate("travel_date"));
                            session.setAttribute("from_location", rs.getString("from_location"));
                            session.setAttribute("to_location", rs.getString("to_location"));
                            session.setAttribute("passenger_count", rs.getInt("passenger_count"));
                            session.setAttribute("aadhar", rs.getString("aadhar"));
                            session.setAttribute("dob", rs.getDate("dob"));
                            session.setAttribute("gender", rs.getString("gender"));
                            session.setAttribute("mobile", rs.getString("mobile"));

                            out.println("<h4>Please Cross-check your Passenger Details:</h4>");
                            out.println("<p>Name: " + rs.getString("name") + "</p>");
                            out.println("<p>Flight Number: " + rs.getString("flight_number") + "</p>");
                            out.println("<p>Airline: " + rs.getString("airline") + "</p>");
                            out.println("<p>Travel Date: " + rs.getDate("travel_date") + "</p>");
                            out.println("<p>From: " + rs.getString("from_location") + "</p>");
                            out.println("<p>To: " + rs.getString("to_location") + "</p>");
                            out.println("<p>Passenger Count: " + rs.getInt("passenger_count") + "</p>");
                            out.println("<p>Aadhar: " + rs.getString("aadhar") + "</p>");
                            out.println("<p>Date of Birth: " + rs.getDate("dob") + "</p>");
                            out.println("<p>Gender: " + rs.getString("gender") + "</p>");
                            out.println("<p>Mobile: " + rs.getString("mobile") + "</p>");
                        } else {
                            out.println("<p>No passenger found with the given mobile number.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                            if (pstmt != null) {
                                pstmt.close();
                            }
                            if (conn != null) {
                                conn.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>

        <!-- OK Button Form to store data -->
        <div class="ok-button">
            <form method="post" action="StorePassengerDetailsServlet">
                <button type="submit" name="submitDetails">OK</button>
            </form>
        </div>

    </body>
</html>
