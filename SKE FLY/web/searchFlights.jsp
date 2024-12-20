<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Available Flights</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }
            .container {
                width: 80%;
                margin: 50px auto;
                background: #ffffff;
                padding: 20px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }
            h2 {
                text-align: center;
                color: #2c3e50; /* Dark green-gray for header */
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #28a745; /* Green */
                color: white;
            }
            tr:nth-child(even) {
                background-color: #d4edda; /* Light green for even rows */
            }
            tr:hover {
                background-color: #c3e6cb; /* Slightly darker green on hover */
            }
            .book-btn {
                padding: 5px 10px;
                background-color: #28a745; /* Green */
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            .book-btn:hover {
                background-color: #218838; /* Darker green on hover */
            }
        </style>

    </head>
    <body>
        <div class="container">
            <h2>Available Flights</h2>
            <%
                String from = request.getParameter("from");
                String to = request.getParameter("to");
                String departureDate = request.getParameter("departure_date");
                String passengerCount = request.getParameter("passengerCount");
                String flightClass = request.getParameter("class");

                // Database connection parameters
                String dbURL = "jdbc:mysql://localhost:3306/User_Login"; // Change to your database name
                String dbUser = "root"; // Change to your database username
                String dbPassword = "Sohail0622"; // Change to your database password

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "SELECT * FROM flights WHERE departure_airport = ? AND arrival_airport = ? AND class = ? AND available_seats > 0";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, from);
                    pstmt.setString(2, to);
                    pstmt.setString(3, flightClass);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
            %>
            <table>
                <tr>
                    <th>Flight Number</th>
                    <th>Airline</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Price (Economy)</th>
                    <th>Price (Business)</th>
                    <th>Action</th>
                </tr>
                <%
                    do {
                %>
                <tr>
                    <td><%= rs.getString("flight_number")%></td>
                    <td><%= rs.getString("airline")%></td>
                    <td><%= rs.getString("departure_time")%></td>
                    <td><%= rs.getString("arrival_time")%></td>
                    <td><%= rs.getDouble("eco_price")%></td>
                    <td><%= rs.getDouble("bus_price")%></td>
                    <td>
                        <form action="BookFlight.jsp" method="get">
                            <input type="hidden" name="flight_number" value="<%= rs.getString("flight_number")%>">
                            <input type="hidden" name="airline" value="<%= rs.getString("airline")%>">
                            <input type="hidden" name="departure_time" value="<%= rs.getString("departure_time")%>">
                            <input type="hidden" name="arrival_time" value="<%= rs.getString("arrival_time")%>">
                            <input type="hidden" name="price" value="<%= rs.getDouble("eco_price")%>">
                            <input type="hidden" name="class" value="<%= flightClass%>">
                            <button type="submit" class="book-btn">Book Flight</button>
                        </form>
                    </td>
                </tr>
                <%
                    } while (rs.next());
                %>
            </table>
            <%
            } else {
            %>
            <p>No flights available for the selected criteria.</p>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (pstmt != null) try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (conn != null) try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </body>
</html>
