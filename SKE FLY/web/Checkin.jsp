<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Check-In</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 60%;
                margin: auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                margin-top: 50px;
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
            }
            .header h1 {
                color: #333;
            }
            .form-group {
                margin-bottom: 20px;
            }
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }
            input[type="text"], input[type="submit"] {
                width: 100%;
                padding: 10px;
                margin: 5px 0 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            input[type="submit"] {
                width: 100%;
                padding: 10px;
                margin: 5px 0 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #28a745; /* Green background */
                color: #fff;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #218838; /* Darker green on hover */
            }

            .details {
                margin-top: 20px;
            }
            .details table {
                width: 100%;
                border-collapse: collapse;
            }
            .details th, .details td {
                text-align: left;
                padding: 8px;
                border: 1px solid #ddd;
            }
            .details th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>Passenger Check-In</h1>
            </div>
            <form method="post">
                <div class="form-group">
                    <label for="pnr">Enter PNR Number:</label>
                    <input type="text" name="pnr" id="pnr" required>
                </div>
                <input type="submit" value="Check-In">
            </form>

            <%
                String pnr = request.getParameter("pnr");
                if (pnr != null && !pnr.isEmpty()) {
                    String url = "jdbc:mysql://localhost:3306/User_Login"; // Update with your DB config
                    String user = "root"; // Your DB username
                    String password = "Sohail0622"; // Your DB password
                    Connection conn = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        String query = "SELECT * FROM passenger_details2 WHERE pnr = ?";
                        pst = conn.prepareStatement(query);
                        pst.setString(1, pnr);
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            String name = rs.getString("name");
                            String flightNumber = rs.getString("flight_number");
                            String airline = rs.getString("airline");
                            String travelDate = rs.getString("travel_date");
                            String fromLocation = rs.getString("from_location");
                            String toLocation = rs.getString("to_location");
                            int passengerCount = rs.getInt("passenger_count");
                            String aadhar = rs.getString("aadhar");
                            String dob = rs.getString("dob");
                            String gender = rs.getString("gender");
                            String mobile = rs.getString("mobile");

                            out.println("<div class='details'>");
                            out.println("<h3>Booking Details</h3>");
                            out.println("<table>");
                            out.println("<tr><th>PNR</th><td>" + pnr + "</td></tr>");
                            out.println("<tr><th>Passenger Name</th><td>" + name + "</td></tr>");
                            out.println("<tr><th>Flight Number</th><td>" + flightNumber + "</td></tr>");
                            out.println("<tr><th>Airline</th><td>" + airline + "</td></tr>");
                            out.println("<tr><th>Travel Date</th><td>" + travelDate + "</td></tr>");
                            out.println("<tr><th>From</th><td>" + fromLocation + "</td></tr>");
                            out.println("<tr><th>To</th><td>" + toLocation + "</td></tr>");
                            out.println("<tr><th>Passenger Count</th><td>" + passengerCount + "</td></tr>");
                            out.println("<tr><th>Aadhar</th><td>" + aadhar + "</td></tr>");
                            out.println("<tr><th>Date of Birth</th><td>" + dob + "</td></tr>");
                            out.println("<tr><th>Gender</th><td>" + gender + "</td></tr>");
                            out.println("<tr><th>Mobile</th><td>" + mobile + "</td></tr>");
                            out.println("</table>");
                            out.println("<form method='post' action='boardingpass.jsp'>"); //baording pass class 
                            out.println("<input type='hidden' name='pnr' value='" + pnr + "'>");
                            out.println("<input type='submit' value='Generate Boarding Pass'>");
                            out.println("</form>");
                            out.println("</div>");
                        } else {
                            out.println("<p style='color: red;'>No booking found for PNR: " + pnr + "</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) {
                            rs.close();
                        }
                        if (pst != null) {
                            pst.close();
                        }
                        if (conn != null) {
                            conn.close();
                        }
                    }
                }
            %>
        </div>
    </body>
</html>
